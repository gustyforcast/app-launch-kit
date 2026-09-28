# Spec: <App Name>

> Stage 1 of the pipeline (see `docs/00-overview-and-workflow.md`).
> This file is the *what and why* — no implementation detail. Freeze it
> before writing `plan.md`. If two sections here disagree with each
> other, resolve that before moving on — don't build through it.

## Problem

What's broken or missing that this app fixes? Who feels this, specifically?

## Non-goals

What this app explicitly will *not* do, even if related or tempting.

## Distinctive feel

The shared conventions are already decided — see
`docs/09-visual-direction.md` — and apply here without re-litigating:
glass surface (`TimDeaconKit`'s `.glassCard()`), one accent color per
app (via the standard Xcode "AccentColor" asset, not a hardcoded
value), monospace/tabular numerals reserved for data readouts only
(`Font.dataReadout` — never for labels or headings).

What's specific to *this* app:

- **This app's one hook** — the single structural idea everything else
  serves (StillTime's is the breathing focus ring). Name it here before
  writing anything else in this doc.
- **This app's accent color** — the one hex value, and why it fits the
  hook/content (not picked for its own sake).
- Reference specific apps/screens/interactions you're drawing from
  beyond the shared direction, and specific pieces of `TimDeaconKit`
  (see `docs/02-design-system-guide.md`) this will reuse vs. extend.

## Core user stories

1. As a [user], I want to [action], so that [outcome].
2. ...

## Research links

- [ ] Competitor apps reviewed:
- [ ] App Store category / keyword gaps found:
- [ ] Relevant technical constraints (APIs, platform limits, etc.):

## Platform & scope

- Platform(s): iOS / macOS / both
- Minimum OS version:
- Offline-first? iCloud sync? Local-only?

## Monetization shape (rough, refined in the marketing plan)

Free / one-time / subscription / hybrid — and why.

## Open questions

Anything still undecided — list it here rather than silently picking an
answer while writing the plan.
