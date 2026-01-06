#!/bin/bash
# Claude Code statusline - Nord theme style

input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name // "Unknown"')
CONTEXT_SIZE=$(echo "$input" | jq -r '.context_window.context_window_size // 200000')
USAGE=$(echo "$input" | jq '.context_window.current_usage // null')

if [ "$USAGE" != "null" ]; then
    CURRENT_TOKENS=$(echo "$USAGE" | jq '.input_tokens + .output_tokens + .cache_creation_input_tokens + .cache_read_input_tokens')
    CONTEXT_PERCENT=$((CURRENT_TOKENS * 100 / CONTEXT_SIZE))
else
    CONTEXT_PERCENT=0
fi

# Nord-inspired colors
BLUE="\033[1;34m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
RED="\033[1;31m"
WHITE="\033[1;37m"
RESET="\033[0m"

# Color based on context usage
if [ "$CONTEXT_PERCENT" -lt 50 ]; then
    PCT_COLOR="$GREEN"
elif [ "$CONTEXT_PERCENT" -lt 80 ]; then
    PCT_COLOR="$YELLOW"
else
    PCT_COLOR="$RED"
fi

echo -e "${WHITE}${MODEL}${RESET} ${BLUE}»${RESET} Context ${PCT_COLOR}${CONTEXT_PERCENT}%${RESET}"
