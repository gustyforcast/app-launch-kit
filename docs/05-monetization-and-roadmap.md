# Monetization, Realistic Expectations & Roadmap

## Tooling

- **[RevenueCat](https://www.revenuecat.com)** for subscription/entitlement
  management — free under $2,500 tracked monthly revenue, best-documented
  Swift SDK of the major options, and the default choice for a first
  subscription app. Add a paywall A/B testing tool (Superwall or Adapty)
  later, once you have enough traffic to make experiments meaningful —
  don't add one on day one.
- **[Appfigures](https://appfigures.com)** (or similar) for download and
  revenue analytics across apps in one dashboard, once you have more than
  one app live.
- Track conversion rate, DAU, D1/D7/D30 retention, churn, and ARPU from
  week one — these are what a roadmap decision should actually be based
  on, not gut feel.

## Setting an honest expected return

Use real base rates, not hope, when writing the revenue-over-months
section of `marketing-plan.md`:

- RevenueCat's 2026 data across 115,000+ apps: **median monthly revenue
  for a subscription app is under $50 after 12 months.** Plan for most
  individual apps to earn little or nothing — this is normal, not a sign
  you did something wrong.
- Concrete solo anchors, for calibration:
  - A solo dev took a habit-tracking app from $0 to $1,000 MRR over
    **8 months** of consistent work.
  - A newer native SwiftUI/SwiftData app from an experienced solo
    developer earned **$874 total** in its first months post-launch,
    while an older app in the same person's portfolio carries the bulk of
    their ~$600K/year — the point being: even someone with a proven
    playbook gets a wide spread across apps.
- **Hard paywalls convert roughly 5x better than freemium** at the
  Day-35 trial-to-paid mark (per RevenueCat's 2026 data) — worth deciding
  explicitly in the plan rather than defaulting to freemium.

Write the projection in `marketing-plan.md` as a range with an explicit
"most likely this earns little" floor case, not a single optimistic
number — that's what "build an expected return over a period of months"
should produce: a defensible range, checked against actual data monthly.

## Portfolio strategy

Given the existing plan to support ~3 earning apps with smaller ones
constantly being tried: this matches a documented pattern where revenue
concentrates in one or two winners inside a larger portfolio (one
developer's 28 apps in 8 months went from $100 to $10K MRR; another's
two-app portfolio has one app carrying nearly all of six figures a year
while the newer one is still near zero). The portfolio approach is a bet
diversification strategy, not a guarantee every app individually earns —
budget your time accordingly and don't over-invest in an app before its
early numbers say to.

## Roadmap cadence — sustaining without a separate PM tool

`docs/roadmap.md` in each app's repo is just a living, prioritized list of
future `spec.md` candidates. Feed it from three inputs, reviewed monthly
once an app is live:

1. **Revenue/retention data** — what's actually working (see tooling
   above).
2. **User feedback** — App Store reviews, support emails, in-app feedback
   if you build a channel for it.
3. **This repo's opportunity-scouting process**, if you're running one, to
   catch adjacent features or gaps before a competitor does.

Promote the top item to a new `spec.md` and re-enter the pipeline at
stage 1. This is how a project "sustains itself": each release cycle is
funded by data from the last one, not by a separate long-range plan
written once and never revisited.
