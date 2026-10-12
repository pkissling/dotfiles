import type {
  EngineInterface as Engine,
  HookStream,
  ProcessSpawnChunk,
  ProcessSpawnResult,
  Register,
} from "claude-code";

const MIN = 60_000;
const TURN_MS = 120 * MIN;
const AGENT_MS = 60 * MIN;
const MONITOR_DEFAULT_MS = 5 * MIN;
const MONITOR_MAX_MS = 30 * MIN;

const leases = new Map<string, number>();
let child: HookStream<ProcessSpawnChunk, ProcessSpawnResult> | undefined;

function sync($: Engine) {
  const now = Date.now();
  for (const [key, until] of leases) if (until <= now) leases.delete(key);
  if (leases.size === 0) {
    void child?.return(undefined as never);
    child = undefined;
    return;
  }
  if (child) return;
  // -t is a backstop in case the release is ever missed; the mod kills it sooner.
  const spawned = $.process.spawn({
    argv: ["caffeinate", "-i", "-s", "-t", String(TURN_MS / 1000)],
  });
  child = spawned;
  void (async () => {
    try {
      for await (const _ of spawned);
    } catch {}
    if (child === spawned) child = undefined;
  })();
}

function hold($: Engine, key: string, ms: number) {
  leases.set(key, Math.max(leases.get(key) ?? 0, Date.now() + ms));
  sync($);
}

function release($: Engine, key: string) {
  leases.delete(key);
  sync($);
}

export const register: Register = (on) => {
  on("session.start", async ($, e, next) => {
    $.clock.every(MIN, () => sync($));
    return next(e);
  });

  on("turn.start", ($, e, next) => {
    hold($, "main", TURN_MS);
    return next(e);
  });

  on("turn.complete", ($, e, next) => {
    release($, e.agentId ?? "main");
    return next(e);
  });

  on("agent.spawn", async ($, e, next) => {
    const spawned = await next(e);
    if ("agentId" in spawned && spawned.agentId)
      hold($, spawned.agentId, AGENT_MS);
    return spawned;
  });

  on("tool.call", { tool: "Monitor" }, async ($, e, next) => {
    hold(
      $,
      e.tool_use_id,
      Math.min(e.timeout_ms ?? MONITOR_DEFAULT_MS, MONITOR_MAX_MS),
    );
    return next(e);
  });
};
