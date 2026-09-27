# Scheduled Research: Keeping the Kit Current

A recurring scheduled task (not part of any single app's repo — it
watches this kit) runs a research cycle and appends findings to
`research/log.md`, updating the docs directly when a finding is clear-cut.

## What it looks for, each run

1. **New bootstrap-friendly tools or pricing changes** relevant to
   `docs/06-bootstrap-ideology-and-tools.md` — a free-tier ceiling that
   moved, a new zero-cost alternative, a tool that started charging.
2. **New case studies of apps reaching meaningful revenue
   (~$3K+/month) within roughly 6 months of launch, bootstrapped with no
   outside capital** — added to `docs/06-bootstrap-ideology-and-tools.md`
   only if the source is concrete (named app, real numbers, identifiable
   founder/writeup), not a vague "how I 10x'd my app" post with no
   specifics.
3. **Changes to Apple/GitHub policy or pricing** that affect this kit's
   assumptions (Actions minute pricing, App Store review policy, Apple
   Developer Program fee, RevenueCat/analytics free-tier limits).
4. **Claude Code / MCP ecosystem changes** relevant to
   `docs/01-tool-stack-and-costs.md` — new versions of XcodeBuildMCP,
   ios-simulator-skill, vexp, or a new tool solving the same problem
   better.
5. **Anything in this kit that's gone stale or wrong** — a broken
   assumption, a dead link, advice that's aged badly.

## What it does with a finding

- **Small, unambiguous update** (a price changed, a link is dead, a new
  free-tier limit): edit the relevant doc directly, note it in
  `research/log.md`, commit with a clear message.
- **New tool/case study worth adding**: add it to the relevant doc's
  table/list in the same style as existing entries, cite the source, log
  it.
- **Bigger judgment call** (a whole new approach, a reason to restructure
  a section): don't just add it — log it as a proposal in
  `research/log.md` under a clearly marked heading and leave the doc
  alone until you're actually asked to act on it.

## Cadence

Weekly. This is slow-moving territory (tool pricing and case studies
don't change day to day) — a daily run would mostly find nothing and burn
tokens for no benefit. Weekly is enough to catch a pricing change or a
good case study before it's stale.

## Guardrails

- Never add a tool or case study without a real source link.
- Never change the ideology in `docs/06` (no capital, profit-only
  reinvestment) — that's a standing decision, not something a research
  pass should second-guess.
- Keep `research/log.md` append-only for the finding itself; only the
  docs get edited in place.
