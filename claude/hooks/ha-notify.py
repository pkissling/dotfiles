#!/usr/bin/env python3
"""Send HA notification after 5 min of waiting for user input."""
import json, os, signal, sys, time
from urllib.request import Request, urlopen

DELAY = 300  # seconds
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


def kill_existing(pid_file):
    try:
        pid = int(open(pid_file).read().strip())
        os.kill(pid, signal.SIGTERM)
    except (FileNotFoundError, ValueError, ProcessLookupError, PermissionError):
        pass
    try:
        os.unlink(pid_file)
    except FileNotFoundError:
        pass


def main():
    hook_input = json.load(sys.stdin)

    if hook_input.get("notification_type") not in ("permission_prompt", "elicitation_dialog"):
        return

    env = load_env()
    token = env.get("AUTH_TOKEN")
    url = env.get("HA_PUBLIC_URL")
    if not token or not url:
        raise RuntimeError("AUTH_TOKEN and HA_PUBLIC_URL must be set in ~/.claude/.env")

    session_id = sys.argv[1]
    pid_file = f"{PID_DIR}/claude-ha-timer-{session_id}.pid"
    tag = f"claude-code-{session_id}"

    # Build message
    cwd = hook_input.get("cwd", "")
    project = os.path.basename(cwd) if cwd else "unknown"
    parts = []
    if project:
        parts.append(f"[{project}]")
    if hook_input.get("title"):
        parts.append(hook_input["title"])
    if hook_input.get("message"):
        parts.append(hook_input["message"])
    message = " ".join(parts) or "Needs your attention"

    # Cancel any existing timer
    kill_existing(pid_file)

    # Fork: child becomes the delayed notifier
    child_pid = os.fork()
    if child_pid > 0:
        with open(pid_file, "w") as f:
            f.write(str(child_pid))
        return

    # --- Child process ---
    os.setsid()
    signal.signal(signal.SIGTERM, lambda *_: sys.exit(0))

    time.sleep(DELAY)

    payload = json.dumps({
        "title": "Claude Code",
        "message": message,
        "tag": tag,
        "hostname": os.uname().nodename,
    }).encode()

    req = Request(
        f"{url}/api/events/claude_code_notify",
        data=payload,
        headers={"Authorization": f"Bearer {token}", "Content-Type": "application/json"},
        method="POST",
    )
    try:
        urlopen(req, timeout=10)
    except Exception:
        pass

    try:
        os.unlink(pid_file)
    except FileNotFoundError:
        pass


if __name__ == "__main__":
    main()
