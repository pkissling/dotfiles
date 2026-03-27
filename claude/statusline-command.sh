#!/usr/bin/env bash
# Claude Code status line
# Format: [🌐 ssh://session@host |] 📂 dir [branch] | 🤖 model | 📊 ctx% | Actions: [⌛🔄|✅❌]

# Read JSON from stdin (provided by Claude Code)
if [ -t 0 ]; then input=""; else input=$(cat 2>/dev/null) || true; fi

# ---------------------------------------------------------------------------
# Section 1 - Connection: ssh://<tmux-session>@<host>
# ---------------------------------------------------------------------------
conn_segment=""
host_name=$(hostname -s 2>/dev/null || echo "$HOSTNAME")
is_ssh=""
tmux_session=""

if [ -n "$SSH_CONNECTION" ] || [ -n "$SSH_TTY" ] || [ -n "$SSH_CLIENT" ]; then
  is_ssh=1
fi

if [ -n "$TMUX" ]; then
  tmux_session=$(tmux display-message -p '#S' 2>/dev/null) || true
fi

if [ -n "$is_ssh" ] || [ -n "$tmux_session" ]; then
  conn_segment=""
  if [ -n "$is_ssh" ]; then
    conn_segment="ssh://"
  fi
  if [ -n "$tmux_session" ]; then
    conn_segment="${conn_segment}${tmux_session}@"
  fi
  conn_segment="🌐 ${conn_segment}${host_name}"
else
  conn_segment="🌐 ${host_name}"
fi

# ---------------------------------------------------------------------------
# Section 2 - Working Directory & Branch
# ---------------------------------------------------------------------------
if [ -n "$input" ]; then
  cwd=$(echo "$input" | jq -r '.cwd // ""')
else
  cwd="$(pwd)"
fi

dir_name="${cwd##*/}"
git_branch=""
if [ -n "$cwd" ]; then
  git_branch=$(git -C "$cwd" --no-optional-locks rev-parse --abbrev-ref HEAD 2>/dev/null) || true
fi

dir_segment="📂 ${dir_name}"
if [ -n "$git_branch" ]; then
  dir_segment="${dir_segment} [${git_branch}]"
fi

# ---------------------------------------------------------------------------
# Section 3 - Model
# ---------------------------------------------------------------------------
if [ -n "$input" ]; then
  model=$(echo "$input" | jq -r '.model.display_name // "unknown"')
else
  model="unknown"
fi

model_segment="🤖 ${model}"

# ---------------------------------------------------------------------------
# Section 4 - Context Window
# ---------------------------------------------------------------------------
if [ -n "$input" ]; then
  context_raw=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
  if [ -n "$context_raw" ]; then
    context=$(printf '%.0f' "$context_raw")
  else
    context="0"
  fi
else
  context="0"
fi

context_segment="📊 ${context}%"

# ---------------------------------------------------------------------------
# Section 5 - GitHub Actions: per-commit status for recent commits
# Only shown when inside a git repo that has .github/workflows
# Shows: [⌛queued 🔄running | ✅pass ❌fail] — always 5 completed results
# ---------------------------------------------------------------------------
_actions_fetch() {
  local cwd="$1"
  local branch="$2"

  # Only proceed if .github/workflows exists in this repo
  local repo_root
  repo_root=$(git -C "$cwd" --no-optional-locks rev-parse --show-toplevel 2>/dev/null) || return 1
  [ -d "${repo_root}/.github/workflows" ] || return 1

  # Resolve owner/repo slug from the origin remote
  local remote_url
  remote_url=$(git -C "$cwd" --no-optional-locks remote get-url origin 2>/dev/null) || return 1
  local repo_slug
  repo_slug=$(echo "$remote_url" \
    | sed -E 's|.*github\.com[:/]||; s|\.git$||')
  [ -n "$repo_slug" ] || return 1

  # Cache per repo+branch; refresh every 60 seconds
  local cache_file="/tmp/.statusline_actions_$(echo "${repo_slug}__${branch}" | tr '/' '_' | tr ':' '_').cache"
  local cache_ttl=60
  local now
  now=$(date +%s)

  if [ -f "$cache_file" ]; then
    local cached_at
    cached_at=$(head -1 "$cache_file" 2>/dev/null) || cached_at=0
    if [ $((now - cached_at)) -lt $cache_ttl ]; then
      tail -n +2 "$cache_file"
      return 0
    fi
  fi

  # Single API call: fetch recent workflow runs for this branch
  local response
  response=$(gh api "repos/${repo_slug}/actions/runs?branch=${branch}&per_page=50" \
    --jq '[.workflow_runs[] | {sha: .head_sha, status: .status, conclusion: .conclusion}]' \
    2>/dev/null) || return 1

  [ -n "$response" ] && [ "$response" != "[]" ] || return 1

  # Classify each commit: group runs by sha, determine per-commit status
  # Output one line per unique commit in order: "queued", "running", "pass", or "fail"
  local statuses
  statuses=$(echo "$response" | jq -r '
    . as $runs |

    # Preserve commit order by first appearance
    [foreach $runs[] as $r (
      {seen: {}, order: []};
      if .seen[$r.sha] then . else .seen[$r.sha] = true | .order += [$r.sha] end;
      .
    )] | last | .order as $order |

    # Group all runs by sha
    [$runs | group_by(.sha)[] | {
      sha: .[0].sha,
      has_queued: ([.[] | select(.status == "queued" or .status == "waiting")] | length > 0),
      has_running: ([.[] | select(.status == "in_progress")] | length > 0),
      has_pending: ([.[] | select(.status != "completed")] | length > 0),
      has_failed: ([.[] | select(.conclusion == "failure" or .conclusion == "cancelled" or .conclusion == "timed_out")] | length > 0)
    }] as $grouped |

    # Emit in original order
    $order[] as $sha |
    ($grouped[] | select(.sha == $sha)) |
    if .has_queued then "queued"
    elif .has_running then "running"
    elif .has_pending then "pending"
    elif .has_failed then "fail"
    else "pass"
    end
  ' 2>/dev/null) || return 1

  [ -n "$statuses" ] || return 1

  # Build icons: queued/running before |, completed after |
  local queued_icons=""
  local running_icons=""
  local completed_icons=""
  local completed_count=0

  while IFS= read -r status; do
    case "$status" in
      queued)  queued_icons="${queued_icons}⌛" ;;
      running) running_icons="${running_icons}🔄" ;;
      pending) running_icons="${running_icons}🔄" ;;
      pass)
        if [ $completed_count -lt 5 ]; then
          completed_icons="${completed_icons}✅"
          completed_count=$((completed_count + 1))
        fi
        ;;
      fail)
        if [ $completed_count -lt 5 ]; then
          completed_icons="${completed_icons}❌"
          completed_count=$((completed_count + 1))
        fi
        ;;
    esac
  done <<< "$statuses"

  [ -n "$queued_icons" ] || [ -n "$running_icons" ] || [ -n "$completed_icons" ] || return 1

  local in_progress="${queued_icons}${running_icons}"
  local result
  if [ -n "$in_progress" ]; then
    result="${in_progress}|${completed_icons}"
  else
    result="${completed_icons}"
  fi
  { echo "$now"; echo "$result"; } > "$cache_file" 2>/dev/null
  echo "$result"
}

actions_segment=""
if [ -n "$cwd" ] && [ -n "$git_branch" ]; then
  commit_icons=$(_actions_fetch "$cwd" "$git_branch")
  if [ $? -eq 0 ] && [ -n "$commit_icons" ]; then
    actions_segment=" | Actions: [${commit_icons}]"
  fi
fi

# ---------------------------------------------------------------------------
# Assemble final output
# ---------------------------------------------------------------------------
output=""
if [ -n "$conn_segment" ]; then
  output="${conn_segment} | "
fi
output="${output}${dir_segment} | ${model_segment} | ${context_segment}${actions_segment}"
echo "$output"
