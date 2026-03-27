#!/bin/bash
# Cancels a pending HA notification for this Claude session
# Also clears any already-delivered notification from the phone via HA REST API
# Multi-instance safe: uses Claude PID to find the correct PID/marker file and notification tag

INPUT=$(cat)

# Source HA config (URL + auth token)
source "${HOME}/.claude/.env" 2>/dev/null || exit 0

# Determine Claude's PID — same detection as ha-notify.sh
CLAUDE_PID=$(awk '{print $4}' /proc/$PPID/stat 2>/dev/null)
if [ -z "$CLAUDE_PID" ] || [ "$CLAUDE_PID" = "1" ]; then
  CLAUDE_PID=$(ps -o pgid= -p $$ 2>/dev/null | tr -d ' ')
fi
ID="${CLAUDE_PID:-default}"
PID_FILE="/tmp/claude-ha-pending-${ID}.pid"
MARKER_FILE="/tmp/claude-ha-active-${ID}"

# Fast exit: no marker means no pending/delivered notification for this session
[ ! -f "$MARKER_FILE" ] && exit 0

# Kill the pending background timer
# Remove PID file first to signal cancellation to the background process
if [ -f "$PID_FILE" ]; then
  PID=$(cat "$PID_FILE")
  rm -f "$PID_FILE"
  pkill -P "$PID" 2>/dev/null
  kill "$PID" 2>/dev/null
fi

# Remove marker file
rm -f "$MARKER_FILE"

TAG="claude-code-${ID}"

# Clear any already-delivered notification
curl -s --max-time 3 -X POST \
  -H "Authorization: Bearer $AUTH_TOKEN" \
  -H "Content-Type: application/json" \
  -d "$(jq -n --arg tag "$TAG" '{tag: $tag}')" \
  "${HA_PUBLIC_URL}/api/events/claude_code_clear" > /dev/null 2>&1

exit 0
