#!/usr/bin/env python3
"""Cancel pending HA notification timer and clear delivered notification."""
import json, os, signal, sys
from urllib.request import Request, urlopen

PID_DIR = "/tmp"


def load_env():
    env = {}
    try:
        with open(os.path.expanduser("~/.claude/.env")) as f:
            for line in f:
                line = line.strip()
                if "=" in line and not line.startswith("#"):
                    k, v = line.split("=", 1)
                    env[k] = v
    except FileNotFoundError:
        pass
    return env


def main():
    sys.stdin.read()

    session_id = sys.argv[1]
    pid_file = f"{PID_DIR}/claude-ha-timer-{session_id}.pid"

    if not os.path.exists(pid_file):
        return

    # Kill the timer process
    try:
        pid = int(open(pid_file).read().strip())
        os.kill(pid, signal.SIGTERM)
    except (ValueError, ProcessLookupError, PermissionError):
        pass
    try:
        os.unlink(pid_file)
    except FileNotFoundError:
        pass

    # Clear any delivered notification
    env = load_env()
    token = env.get("AUTH_TOKEN")
    url = env.get("HA_PUBLIC_URL")
    if not token or not url:
        raise RuntimeError("AUTH_TOKEN and HA_PUBLIC_URL must be set in ~/.claude/.env")

    tag = f"claude-code-{session_id}"
    payload = json.dumps({"tag": tag}).encode()
    req = Request(
        f"{url}/api/events/claude_code_clear",
        data=payload,
        headers={"Authorization": f"Bearer {token}", "Content-Type": "application/json"},
        method="POST",
    )
    try:
        urlopen(req, timeout=3)
    except Exception:
        pass


if __name__ == "__main__":
    main()
