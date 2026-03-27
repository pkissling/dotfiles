#!/bin/bash
# Sends a Home Assistant notification when Claude Code has been waiting for 5 minutes
# Uses a background timer pattern: spawns a delayed sender, saves PID for cancellation
# When the user responds, ha-cancel.sh kills the timer and clears any delivered notification
# Multi-instance safe: uses Claude PID to create unique PID/marker files and notification tags

# Read hook input from stdin
INPUT=$(cat)

# Only notify when user input is actually required
NOTIFICATION_TYPE=$(echo "$INPUT" | jq -r '.notification_type // empty')
case "$NOTIFICATION_TYPE" in
  permission_prompt|elicitation_dialog) ;;  # These need user input — continue
  *) exit 0 ;;  # Everything else (task done, etc.) — skip
esac

# Source HA config (URL + auth token)
source "${HOME}/.claude/.env" 2>/dev/null || exit 0

# Determine Claude's PID for instance-specific files
# Parent of our parent (bash -c wrapper) is the claude binary
CLAUDE_PID=$(awk '{print $4}' /proc/$PPID/stat 2>/dev/null)
if [ -z "$CLAUDE_PID" ] || [ "$CLAUDE_PID" = "1" ]; then
  # Fallback: Claude sets the process group ID to its own PID
  CLAUDE_PID=$(ps -o pgid= -p $$ 2>/dev/null | tr -d ' ')
fi
ID="${CLAUDE_PID:-default}"
PID_FILE="/tmp/claude-ha-pending-${ID}.pid"
MARKER_FILE="/tmp/claude-ha-active-${ID}"

# Kill any existing pending notification for this session
# Remove PID file first to signal cancellation to the background process
if [ -f "$PID_FILE" ]; then
  OLD_PID=$(cat "$PID_FILE")
  rm -f "$PID_FILE"
  pkill -P "$OLD_PID" 2>/dev/null
  kill "$OLD_PID" 2>/dev/null
fi

# Extract context from the hook payload
MESSAGE=$(echo "$INPUT" | jq -r '.message // empty')
TITLE=$(echo "$INPUT" | jq -r '.title // empty')
CWD=$(echo "$INPUT" | jq -r '.cwd // empty')
PROJECT=$(basename "$CWD" 2>/dev/null || echo "unknown")
HOSTNAME=$(hostname)

# Build notification message with as much context as possible
PARTS=()
[ -n "$PROJECT" ] && PARTS+=("[$PROJECT]")
[ -n "$TITLE" ] && PARTS+=("$TITLE")
[ -n "$MESSAGE" ] && PARTS+=("$MESSAGE")

if [ ${#PARTS[@]} -gt 0 ]; then
  NOTIFY_MESSAGE="${PARTS[*]}"
else
  NOTIFY_MESSAGE="Needs your attention"
fi

TAG="claude-code-${ID}"

# Mark this session as having a pending notification
touch "$MARKER_FILE"

# Spawn background process: wait 5 minutes, then send notification via HA REST API
(
  MY_PID=$BASHPID
  sleep 300

  # Race condition guard: if PID file is gone or contains a different PID,
  # ha-cancel.sh already ran — do not send the notification
  if [ ! -f "$PID_FILE" ] || [ "$(cat "$PID_FILE" 2>/dev/null)" != "$MY_PID" ]; then
    rm -f "$MARKER_FILE"
    exit 0
  fi

  # Check if Claude is still alive; verify comm to guard against PID reuse
  if [ -n "$CLAUDE_PID" ] && [ "$CLAUDE_PID" != "1" ]; then
    if ! [ -d "/proc/$CLAUDE_PID" ] || \
       [ "$(cat /proc/$CLAUDE_PID/comm 2>/dev/null)" != "claude" ]; then
      rm -f "$PID_FILE" "$MARKER_FILE"
      exit 0
    fi
  fi

  curl -s -X POST \
    -H "Authorization: Bearer $AUTH_TOKEN" \
    -H "Content-Type: application/json" \
    -d "$(jq -n --arg title "Claude Code" --arg message "$NOTIFY_MESSAGE" \
            --arg tag "$TAG" --arg hostname "$HOSTNAME" \
      '{title: $title, message: $message, tag: $tag, hostname: $hostname}')" \
    "${HA_PUBLIC_URL}/api/events/claude_code_notify" > /dev/null 2>&1
  rm -f "$PID_FILE"
) &

# Save background PID for cancellation
echo $! > "$PID_FILE"

exit 0
