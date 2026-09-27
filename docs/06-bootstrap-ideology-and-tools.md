# Bootstrap Ideology: No Capital In, Only Profit Reinvested

## The rule

No external capital goes into this — no ad spend, no paid tools, no
loans, funded from savings or income, before an app is earning. The only
money that ever goes toward growing this portfolio is **money the
portfolio itself has already earned**. Every tool choice below is made
under that constraint, and the one genuinely unavoidable exception is
called out explicitly rather than hidden.

## The one real floor cost

The **Apple Developer Program is $99/year**, non-negotiable, required to
put anything on the App Store or TestFlight at all — there is no free
tier that reaches real users. This is infrastructure, not marketing
spend, and it's the one line item that exists before revenue does.
GitHub Pro ($4/month, see `docs/01-tool-stack-and-costs.md`) is the other
near-zero fixed cost worth carrying. Everything else in this doc is $0
until profit exists to reinvest.

## What "$3,000/month within 6 months" actually looks like against real data

Be honest with yourself about this target before building a plan around
it:

- RevenueCat's 2026 data across 115,000+ apps: **median monthly revenue
  for a subscription app is under $50 after 12 months.** $3K/month in 6
  months is a strong outcome, not a typical one.
- Concrete anchors for what *is* achievable on this timeline, bootstrapped,
  with no ad budget beyond tiny reinvested tests:
  - **Habit Pixel** (solo dev, cross-platform): $0 → **$1,000 MRR in 8
    months**. Spend was near-zero — a "$10/day" Meta ads test funded
    entirely from a Black Friday promotion's proceeds, not upfront
    capital. The growth inflection came from building in public on
    X/Threads/BlueSky, App Store keyword-focused ASO (reached top-15 in
    its category on Google Play), and purchasing-power-parity pricing
    that opened Southeast Asia and Latin America overnight. ([Indie
    Hackers writeup](https://www.indiehackers.com/post/from-0-to-1k-mrr-in-8-months-bootstrapping-habit-pixel-as-a-solo-dev-684b6c056d))
  - Several $3K–10K MRR-in-6-months stories exist but skew SaaS/web
    (not App Store), often with the founder's existing audience doing a
    lot of the early work — treat these as upper bound, not baseline.
    ([SoftwareSeni roundup](https://www.softwareseni.com/solo-founder-saas-metrics-from-0-to-10k-mrr-in-6-months-with-realistic-timelines/))
- **Takeaway for the roadmap**: $3K/month in 6 months from one app is the
  stretch case, not the base case. The portfolio approach already in
  `docs/05-monetization-and-roadmap.md` — several small bets, revenue
  concentrating in one or two winners — is the realistic path to that
  number, not expecting any single first app to hit it alone. Build the
  plan so a $3K *combined* run-rate across 2–3 apps by month 6 counts as
  success, and treat one app doing it alone as upside.

## Zero-capital tool stack, iOS/macOS-specific

Every category below defaults to the free tier. Reinvest earned profit to
upgrade a specific one only once it's the actual bottleneck — not
pre-emptively.

| Category | Free-tier tool | Ceiling before you'd pay | Reinvest into, once earning |
|---|---|---|---|
| Source control + CI | GitHub Free (public) / Pro ($4/mo) | 2,000–3,000 min/mo, macOS at 10x | More Actions minutes, or a self-hosted Mac mini runner |
| Subscriptions/entitlements | RevenueCat free tier | $2,500 tracked monthly revenue | RevenueCat paid tier (1% of MTR) |
| Crash/error monitoring | Sentry free tier | 5K errors/mo | Sentry paid |
| Analytics | App Store Connect's own analytics (free, built-in) + PostHog free tier | 1M events/mo on PostHog | Appfigures (paid, cross-app dashboard) once running 2+ apps |
| ASO / keyword research | [AppFollow's free ASO tools](https://appfollow.io/free-aso-tools), [ASOMobile's free tools](https://asomobile.net/en/free-tools/), [AwesomeASO](https://www.awesomeaso.com/) (built for indies specifically) | Most cap history depth / competitor count | Sensor Tower / Mobile Action once keyword strategy needs deeper competitor data |
| Paid acquisition | **None, by design, until organic + ASO plateau** | — | Apple Search Ads (self-serve, pay-per-tap — the only paid channel worth testing early, funded from revenue, small daily cap) |
| Design assets | SF Symbols (free, Apple's own), your own `TimDeaconKit` design system | — | Stock asset libraries only if a specific app genuinely needs them |
| Landing page | A GitHub Pages / Cloudflare Pages static page (both free) | Bandwidth limits rarely hit at this scale | — |
| Email (waitlist/updates) | Loops or Resend free tier (3K–10K contacts/emails) | Listed limits | Paid tier once list is actually that big |

## What "financial decisions to improve performance" should mean in practice

The instruction to make financial decisions only by *diverting profits*
means: every paid upgrade in the table above is a decision to log in
`docs/roadmap.md`, triggered by a specific bottleneck an app has actually
hit (e.g. "RevenueCat free tier ceiling reached because App X crossed
$2,500 MTR" — that's a good problem, and the $2,500 already earned is what
pays for removing it). Never spend ahead of that evidence. Apple Search
Ads is the single exception worth normalizing early, because it's the
only acquisition channel that's inherently self-limiting (you set the
daily cap, spend equals exactly what you allow) — fund a test of it only
from an app's own prior month's revenue, never from outside money.

## Where this feeds back into the pipeline

- `templates/marketing-plan.md`'s "Expected return" section should now
  reference the $3K/6mo target explicitly as a *portfolio* goal, and cite
  the Habit Pixel-style timeline as the realistic single-app case.
- `templates/roadmap.md`'s review log is where a "reinvest here" decision
  gets recorded, with the specific bottleneck and the revenue that's
  funding it.
