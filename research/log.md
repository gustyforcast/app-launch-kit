# Kit Research Log

Appended to by the scheduled "improve app-launch-kit" research task (see
`docs/07-scheduled-research.md` for what it looks for and how often it
runs). Each entry is a dated finding — a new bootstrap-friendly tool, a
case study worth adding to `docs/06-bootstrap-ideology-and-tools.md`, a
change to Apple/GitHub pricing or policy that affects this kit's
assumptions, or a correction to something already in the docs.

Entries that turn into an actual doc/template change get a note here
saying which file changed, so this log stays the audit trail rather than
a second copy of the docs.

## 2026-09-27

First run of the scheduled research task. Covered a broad first pass
across all four watch areas since there's no prior rotation history yet;
future runs should rotate focus per `docs/07-scheduled-research.md`.

**Changed `docs/01-tool-stack-and-costs.md` and
`scripts/install-claude-tools.sh`:**

- **XcodeBuildMCP was renamed to MobileBuildMCP** by Sentry. Same project,
  new repo (`getsentry/XcodeBuildMCP` → `getsentry/MobileBuildMCP`) and new
  npm package (`xcodebuildmcp` → `mobilebuildmcp`, now at v2.7.1; the old
  package is frozen at v2.7.0). Updated the doc's link/name and the
  install script's `claude mcp add` command. Left the `XCODEBUILDMCP_*`
  env var names alone since Sentry's own docs site still uses that prefix
  post-rename — flagged in a script comment to double check if it breaks.
  Sources: [getsentry/MobileBuildMCP
  README](https://github.com/getsentry/MobileBuildMCP),
  [mobilebuildmcp on npm](https://www.npmjs.com/package/mobilebuildmcp).
- **ios-simulator-skill now installs as a Claude Code plugin**
  (`/plugin marketplace add conorluddy/ios-simulator-skill` +
  `/plugin install ios-simulator-skill@conorluddy`), replacing the old
  manual-clone instructions (the repo restructured to a plugin layout
  where a bare clone puts `SKILL.md` too deep to load). Source:
  [conorluddy/ios-simulator-skill
  README](https://github.com/conorluddy/ios-simulator-skill).

**Checked, no change needed** (docs already current):
- RevenueCat free tier: still $2,500 tracked MTR free, 1% of MTR paid —
  matches `docs/06`.
- Sentry free tier: still 5K errors/month — matches `docs/06`.
- GitHub Actions macOS runner pricing: still ~$0.062/min at a 10x minute
  multiplier — matches `docs/01`. (GitHub proposed a $0.002/min platform
  fee for self-hosted runners for March 2026 but reportedly postponed it
  indefinitely after backlash; it was never in our docs, so nothing to
  revert.)
- Apple Developer Program fee: still $99/year, no change.
- App Store Review Guidelines / Developer Agreement update (June 8,
  2026): clarifications (IAP API wording, Live Activities anti-spam, teen
  safety guidance) and new optional frameworks (Sensitive Content
  Analysis, Foundation Models, etc.) — nothing that touches this kit's
  cost or workflow assumptions.
- vexp: actively updated (v3.3.0 on npm, 87 releases) but found no
  evidence of a free-tier or pricing change to the "free for a single
  small repo" claim in `docs/01`. Left as-is.

**Proposal (not applied — judgment call, see guardrails in `docs/07`):**

HabitKit (solo dev Sebastian Röhl, iOS + Android habit tracker) is a very
well-documented bootstrapped success — no outside capital, $602K revenue
in 2025, ~$28-40K MRR, 25K+ paying subscribers, corroborated by his own
[Substack](https://sebastianroehl.substack.com/p/2025-the-year-that-changed-everything)
and a [RevenueCat interview](https://www.revenuecat.com/blog/growth/sebastian-rohl-habitkit-launched-podcast-2026).
Tempting to add to `docs/06`'s case-study list, but I could not confirm
from primary sources that it hit $3K+/month within 6 months of its
November 2022 launch specifically (one secondary aggregator claims "$5K
MRR by end of 2022," ~1-2 months post-launch, but that figure isn't
corroborated by Sebastian's own posts or the RevenueCat piece, so I'm not
citing it as fact). If someone wants it added anyway as a longer-horizon
"what's achievable over years, not just 6 months" data point rather than
a 6-month case study, that's a call for a person to make, not this
research pass.

---

<!-- New entries are added above this line, newest first. -->
