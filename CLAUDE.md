# <App Name> — Claude Code notes

Platform: <PLATFORM>. Built from
[app-launch-kit](https://github.com/gustyforcast/app-launch-kit).

## Read before working

- `docs/spec.md` — what this app is and isn't. Don't contradict it; if it
  needs to change, change it explicitly and say so.
- `docs/plan.md` — the technical shape. Follow it unless there's a good
  reason not to, in which case update it.
- `docs/tasks.md` — the current task list. Check off finished tasks in the
  same commit that finishes them.

## Working rules

- This may run as a cloud (no Xcode) session or an on-device session —
  check which tools you actually have before assuming you can build.
  Cloud sessions: write code, tests, docs. On-device or CI: build, run on
  simulator, sign, release.
- Don't guess at `xcodebuild` invocations by hand if XcodeBuildMCP is
  available — use it.
- A task isn't done until CI is green (see `.github/workflows/`), not
  because it compiles locally in your head.
- If you're about to write a UI component that feels like it belongs in
  every app, not just this one, say so — it probably belongs in the
  shared design-system package (`YourNameKit`), not here.
- Keep this file short. Point at `docs/`, don't duplicate it here.
