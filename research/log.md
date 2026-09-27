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

## 2026-09-27 (second pass)

Rotated focus this run toward: resolving last run's open question about the
MobileBuildMCP env-var rename, a fresh case-study search, and rechecking
RevenueCat/GitHub Actions pricing given some "new pricing" chatter in
search results.

**Changed `docs/01-tool-stack-and-costs.md` and
`scripts/install-claude-tools.sh`:**

- **MobileBuildMCP's env var rename is confirmed.** Last run's entry left
  `XCODEBUILDMCP_*` in place and flagged it to double-check. The v2.7.1
  release notes confirm the full rename: env var prefix
  `XCODEBUILDMCP_*` → `MOBILEBUILDMCP_*`, state dir
  `~/Library/Developer/XcodeBuildMCP` → `.../MobileBuildMCP`, project
  config dir `.xcodebuildmcp/` → `.mobilebuildmcp/`. Updated the install
  script's `-e` flags and added a note to the doc. Source: [MobileBuildMCP
  v2.7.1 release](https://github.com/getsentry/MobileBuildMCP/releases/tag/v2.7.1).
- **vexp's free tier now has stated numeric limits** instead of the vague
  "free for a single small repo": ≤2,000 nodes, single-repo workspace, 20
  pipeline+skeleton calls/day, no account required. Also repositioned from
  "context engine" to "the reliability layer for AI coding agents" (context
  delivery + mechanical verification of agent work) — noted in the doc.
  Paid tiers are Pro ($19/mo, 50K nodes/3 repos) and Team ($29/user/mo,
  unlimited) if a project ever outgrows the free ceiling. Source:
  [vexp.dev](https://vexp.dev/).

**Checked, no change needed:**

- **RevenueCat pricing**: RevenueCat unified its old Free/Starter/Pro/
  Grow/Analyze legacy plans into one plan this year — worth confirming
  since it sounded like a bigger change than it is. The new unified terms
  are **$2,500 free tracked MTR, then 1% of MTR** — exactly what's already
  in `docs/06`. No doc change needed, but worth having explicitly
  reconfirmed rather than assumed given the "new pricing" headlines.
  Source: [RevenueCat: Navigating RevenueCat's new pricing for existing
  users](https://www.revenuecat.com/blog/company/navigating-revenuecats-new-pricing-for-existing-users).
- **GitHub Actions runner pricing**: confirmed the `$0.062/min` macOS
  figure already in `docs/01` is the *current*, post-cut rate (GitHub cut
  hosted-runner prices up to 39% effective Jan 1, 2026: macOS
  $0.080→$0.062/min, Linux $0.008→$0.006/min, Windows $0.016→$0.010/min;
  the 10x/1x/2x OS multipliers on included minutes are unchanged, and the
  proposed self-hosted-runner platform fee stays postponed). Nothing to
  update — just resolves any ambiguity about which side of the cut our
  number was on. Source: [GitHub Changelog, reduced hosted-runner
  pricing](https://github.blog/changelog/2026-01-01-reduced-pricing-for-github-hosted-runners-usage/).
- **App Store Review Guidelines**: a Feb 6, 2026 clarification (random/
  anonymous chat apps fall under the 1.2 UGC guideline — content filters,
  reporting, blocking, published contact info required) predates and is
  separate from the June 8 spam/low-quality crackdown already logged last
  run. Neither touches this kit's generic templates (no chat feature
  assumed), so no change.
- **MobileBuildMCP version**: still v2.7.1 on npm; only dependency bumps
  since the rename release, nothing functional.

**Case studies — searched, nothing added:**

Looked for a fresh $3K+/month-in-~6-months solo/small-team iOS/macOS case
study to avoid relying solely on last run's Habit Pixel anchor and the
not-quite-qualifying HabitKit proposal. Nothing found this run clears the
bar in `docs/07`:

- **SuperX** ($23K MRR in 6 months, 2 co-founders, no outside funding) —
  well-sourced but it's a web app + Chrome extension, not iOS/macOS.
  ([Indie Hackers](https://www.indiehackers.com/post/tech/hitting-23k-mrr-in-six-months-after-five-failures-4d64o9ev4AXXhX9ogHQQ))
- **Viktor Seraleev / Sarafan Mobile** ($60.1K in Dec 2025 proceeds, 30+
  solo-built iOS apps, no outside capital, one app sold for $410K) — real
  and well-documented, but it's a portfolio built up since 2020, not a
  6-month timeline, so it doesn't fit the case-study criterion as written.
  Same shape as the HabitKit proposal already logged: a "years, not 6
  months" data point. ([Indie Hackers](https://www.indiehackers.com/post/tech/building-an-app-portfolio-to-60k-mo-after-apple-froze-his-developer-account-LD7oNYzKSmWucRfKV1AO))
- **RocketSim** (Antoine van der Lee, solo, no outside capital, "approaching
  $100K ARR" as of March 2026) — a real solo iOS-tooling business, but the
  source doesn't give a launch date or 6-month figure, so there's nothing
  concrete enough to cite. ([RevenueCat](https://www.revenuecat.com/blog/growth/antoine-van-der-lee-rocketsim-launched-podcast-2026/))

Most other search results were SEO-aggregator "how I hit $10K MRR"
roundups with no named founder or verifiable numbers — skipped per the
"real source" guardrail.

**Proposal (not applied — judgment call, see guardrails in `docs/07`):**

Apple announced native Claude Agent SDK integration in **Xcode 26.3**
(Feb 3, 2026, released as an App Store update for Developer Program
members): Claude can explore a project's file structure, capture and
iterate on Xcode Previews, and drive builds/fixes from inside Xcode
itself, and Xcode 26.3 also exposes its own capabilities over MCP so an
external Claude Code session can drive it. This is potentially relevant
to `docs/01-tool-stack-and-costs.md`'s on-device tooling section — it
could reduce or replace the need for a third-party MCP server like
MobileBuildMCP for some on-device workflows (or it could turn out to be
complementary; Apple's own announcement doesn't spell out how the two
compare on things like device installs or simulator screenshot capture,
which MobileBuildMCP explicitly handles). Sources: [Anthropic: Apple
Xcode Claude Agent SDK](https://www.anthropic.com/news/apple-xcode-claude-agent-sdk),
[AlternativeTo coverage](https://alternativeto.net/news/2026/2/xcode-26-3-adds-agentic-coding-with-claude-agent-codex-and-other-ai-tools-via-mcp).
Not restructuring `docs/01` on this alone — worth someone with an actual
Xcode 26.3 install trying both side by side before the doc recommends
one over the other.

---

<!-- New entries are added above this line, newest first. -->
