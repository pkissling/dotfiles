#!/usr/bin/env bash

if [ -t 0 ]; then input='{}'; else input=$(cat 2>/dev/null) || input='{}'; fi

# Unit separator instead of tab: bash `read` collapses consecutive tabs, dropping empty fields.
IFS=$'\x1f' read -r cwd model effort context added removed < <(jq -r '[
  (.cwd // ""),
  (.model.display_name // "unknown"),
  (.effort.level // ""),
  (.context_window.used_percentage // 0 | floor | tostring),
  (.cost.total_lines_added // 0 | tostring),
  (.cost.total_lines_removed // 0 | tostring)
] | join("\u001f")' <<<"$input" 2>/dev/null)
cwd=${cwd:-$PWD}
context=${context:-0}

# Nord palette, bold like the starship prompt.
style() { printf '\033[1;38;2;%sm' "$1"; }
reset=$'\033[0m'
text=$(style '229;233;240')
muted=$'\033[38;2;216;222;233m'
blue=$(style '129;161;193')
green=$(style '163;190;140')
yellow=$(style '235;203;139')
red=$(style '191;97;106')
sep="${blue}»${reset}"

segments=()

dir_segment="${text}${cwd##*/}${reset}"
{ read -r root; read -r common; } < <(git -C "$cwd" --no-optional-locks rev-parse --path-format=absolute --show-toplevel --git-common-dir 2>/dev/null)
if [ -n "$common" ] && [ "${common%/.git}" != "$root" ]; then
  repo=${common%/.git}
  dir_segment="${text}${repo##*/}${reset} ${muted}${cwd#"${root%/*}"/}${reset}"
fi
segments+=("$dir_segment")

branch="" ahead=0 behind=0 status=""
while IFS= read -r line; do
  case "$line" in
    "# branch.head "*) branch=${line#\# branch.head } ;;
    "# branch.ab "*) read -r _ _ ahead behind <<<"$line"; ahead=${ahead#+}; behind=${behind#-} ;;
    "? "*) [[ $status == *\?* ]] || status="${status}?" ;;
    [12u]" "*)
      [[ ${line:2:1} != . && $status != *+* ]] && status="${status}+"
      [[ ${line:3:1} != . && $status != *!* ]] && status="${status}!"
      ;;
  esac
done < <(git -C "$cwd" --no-optional-locks status --porcelain=v2 --branch 2>/dev/null)
if [ -n "$branch" ]; then
  [ "$ahead" -gt 0 ] && status="${status}⇡${ahead}"
  [ "$behind" -gt 0 ] && status="${status}⇣${behind}"
  git_segment="${text}${branch}${reset}"
  [ -n "$status" ] && git_segment="${git_segment} ${red}[${status}]${reset}"
  segments+=("$git_segment")
fi

if [ -n "$AWS_PROFILE" ] && [ "$(cat "${HOME}"/dotfiles/.profile 2>/dev/null)" = "work" ]; then
  case "$AWS_PROFILE" in
    *prod*) aws_segment="${red}aws:${AWS_PROFILE}${reset}" ;;
    *) aws_segment="${text}aws:${AWS_PROFILE}${reset}" ;;
  esac
  account=$(awk -v section="[profile ${AWS_PROFILE}]" '$0 == section { found = 1; next } /^\[/ { found = 0 } found && $1 == "sso_account_id" { print $3; exit }' ~/.aws/config 2>/dev/null)
  [ -n "$account" ] && aws_segment="${aws_segment} ${blue}${account}${reset}"
  "${HOME}"/dotfiles/starship/helper/aws_sso_expired_check.sh && aws_segment="${aws_segment} 🔒"
  segments+=("$aws_segment")
fi

model_segment="${text}${model}${reset}"
[ -n "$effort" ] && model_segment="${model_segment} ${muted}${effort}${reset}"
segments+=("$model_segment")

if [ "$context" -ge 80 ]; then ctx_color=$red
elif [ "$context" -ge 50 ]; then ctx_color=$yellow
else ctx_color=$green
fi
filled=$(( (context + 5) / 10 ))
printf -v on '%*s' "$filled" ''
printf -v off '%*s' $((10 - filled)) ''
segments+=("${ctx_color}${on// /▰}${off// /▱}${reset}  ${text}${context}%${reset}")

if [ "${added:-0}" -gt 0 ] || [ "${removed:-0}" -gt 0 ]; then
  segments+=("${green}+${added}${reset} ${red}-${removed}${reset}")
fi

actions_fetch() {
  local slug cache now runs icons
  [ -d "${root}/.github/workflows" ] || return 1
  slug=$(git -C "$cwd" --no-optional-locks remote get-url origin 2>/dev/null | sed -E 's|.*github\.com[:/]||; s|\.git$||')
  [ -n "$slug" ] || return 1

  cache="${TMPDIR:-/tmp}/.statusline_actions_$(tr '/:' '__' <<<"${slug}__${branch}").cache"
  now=$(date +%s)
  if [ -f "$cache" ] && [ $((now - $(head -1 "$cache"))) -lt 60 ]; then
    tail -n +2 "$cache"
    return 0
  fi

  runs=$(gh api "repos/${slug}/actions/runs?branch=${branch}&per_page=50" \
    --jq '[.workflow_runs[] | {sha: .head_sha, status, conclusion}]' 2>/dev/null) || return 1

  icons=$(jq -r --arg green "$green" --arg red "$red" --arg yellow "$yellow" --arg reset "$reset" '
    (map(.sha) | reduce .[] as $s ([]; if index([$s]) then . else . + [$s] end)) as $order
    | group_by(.sha) | map({key: .[0].sha, value: (
        if any(.status != "completed") then "pending"
        elif any(.conclusion == "failure" or .conclusion == "cancelled" or .conclusion == "timed_out") then "fail"
        else "pass" end)}) | from_entries as $state
    | [$order[] | $state[.]] as $all
    | ([$all[] | select(. == "pending")] | length) as $pending
    | ([$all[] | select(. != "pending")][:5] | map(if . == "pass" then $green + "●" else $red + "●" end) | join("")) as $done
    | (if $pending > 0 then $yellow + "◌" * $pending + " " else "" end) + $done + $reset
  ' <<<"$runs" 2>/dev/null) || return 1
  [ -n "$icons" ] || return 1

  printf '%s\n%s\n' "$now" "$icons" >"$cache" 2>/dev/null
  echo "$icons"
}

if [ -n "$branch" ] && actions=$(actions_fetch) && [ -n "$actions" ]; then
  segments+=("${text}ci${reset} ${actions}")
fi

out=${segments[0]}
for s in "${segments[@]:1}"; do
  out="${out} ${sep} ${s}"
done
printf '%s\n' "$out"
