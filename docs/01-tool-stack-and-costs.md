# Tool Stack & Costs

## The core split: cloud/git vs. on-device

Claude Code running in the cloud (no local Mac) is cheap and fast for
anything that's ultimately a text diff: specs, plans, Swift/SwiftUI
refactors, writing tests, scaffolding new modules. It **cannot** invoke
`xcodebuild`, boot the iOS Simulator, or render a SwiftUI preview — that
needs an actual macOS toolchain.

| Work | Where |
|---|---|
| Spec/plan/tasks writing, research | Cloud Claude Code |
| Refactors, new features, cross-file Swift changes | Cloud Claude Code |
| Writing unit/logic tests | Cloud Claude Code |
| Build verification, simulator/UI testing | On-device Claude Code, or CI on a macOS runner |
| Signing, provisioning, App Store submission | On-device, or CI with secrets |

Don't try to make the cloud session do Xcode's job. Push the code, let a
macOS CI job (or an on-device session) verify it.

## GitHub plan & Actions minutes

- **GitHub Pro is $4/month** and buys you 3,000 Actions minutes/month plus
  required-reviewer support on private repos — worth it as soon as you're
  running any CI on a private app repo.
- Minutes are metered by an OS multiplier: **Linux ≈1x, Windows ≈2x, macOS
  ≈10x**. Your 3,000 Pro minutes are Linux-equivalent, so they're really
  only ~300 minutes of macOS build time before you're billed per-minute
  (macOS runs ~$0.062/min as of 2026).
- **Public repos get unlimited free minutes on standard runners, including
  macOS** — this is why this kit itself (no proprietary app code) is
  public, but any app repo that might earn money should stay **private**
  and live inside the metered allowance.
- Practical consequence: don't run a full macOS/simulator build on every
  commit. Run pure-logic tests (anything not importing UIKit/SwiftUI) as
  Swift Package tests on cheap Linux runners on every push, and reserve
  the macOS job for PRs into `main` and release tags. See
  `docs/03-ci-testing.md` for the actual workflow files.

## MCP servers / Claude Code tooling worth installing

Install these with `scripts/install-claude-tools.sh`.

- **[XcodeBuildMCP](https://github.com/getsentry/XcodeBuildMCP)** — the
  standard MCP server for driving `xcodebuild`, the simulator, and device
  installs from an on-device Claude Code session. Use it whenever Claude
  needs to build, run, or screenshot the app itself, rather than having it
  guess at raw `xcodebuild` invocations.
- **[ios-simulator-skill](https://github.com/conorluddy/ios-simulator-skill)**
  — a Claude Code skill specifically built to reduce token/context waste
  when proxying `xcodebuild` and simulator interaction, including handling
  slow GitHub Actions macOS runner boot times. Pairs well with
  XcodeBuildMCP.
- **[vexp](https://vexp.dev)** — a local-first context engine (MCP, zero
  network calls, free for a single small repo). It indexes your codebase
  into a dependency graph and hands Claude compact "capsules" — full
  source for the file that matters, skeleton signatures for everything
  adjacent — instead of dumping whole files into context. Their own
  numbers: ~74% token reduction on a sample query, and on SWE-bench Pro,
  Opus + vexp matched a pricier model's results at roughly half the token
  cost. Worth trying against any repo that's grown past a few files.

## General token-management habits

These aren't tool-specific, just consistently recommended across the
Claude Code community:

- Keep the root `CLAUDE.md` short — don't auto-load full docs, changelogs
  or session history into every session's starting context. Point at
  files; don't paste them in.
- Avoid dumping full file contents or verbose command output into
  context — grep/search for the relevant slice instead of `cat`-ing whole
  files.
- Use subagents for exploration so only the synthesis comes back to the
  main thread.
- Run `/compact` proactively in long sessions rather than letting context
  balloon silently.
- A `claude-usage-analyzer`-style tool (search GitHub) can show which
  sessions/tools/projects are actually burning tokens if costs feel out of
  proportion to the work.

## Design tooling

Figma's relevant pieces here are **Dev Mode** (design → code handoff) and
**Figma Make** (prompt-to-code) — useful if you're specifying a screen to
Claude by reference to a Figma frame instead of prose, but it's a
design-workflow aid, not a cost-reduction tool. Treat it as optional; the
design-system package (`docs/02-design-system-guide.md`) is the piece that
actually compounds across apps.
