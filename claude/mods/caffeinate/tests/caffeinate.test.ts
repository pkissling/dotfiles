import { expect, test } from "claude-code/testing";

test("holds caffeinate for a turn and releases it when the turn completes", async ($, on) => {
  const live: string[][] = [];
  let killed!: () => void;
  const wasKilled = new Promise<void>((r) => (killed = r));
  on("process.spawn", async function* (_$, e, next) {
    live.push([...e.argv]);
    try {
      await new Promise<void>((r) =>
        next.signal.addEventListener("abort", () => r()),
      );
    } finally {
      live.pop();
      killed();
    }
    return { value: { code: 0, signal: null } };
  });
  on("turn.start", (_$, e) => ({ turnId: e.turnId }));
  on("turn.complete", () => ({ text: "" }));

  await $.turn.start({ text: "hi", turnId: "t1" });
  await Promise.resolve();
  expect(live[0]?.slice(0, 3)).toEqual(["caffeinate", "-i", "-s"]);

  await $.turn.complete({
    answer: "",
    durationMs: 1,
    isAborted: false,
    reason: "answer",
    turnId: "t1",
  });
  await wasKilled;
  expect(live).toHaveLength(0);
});
