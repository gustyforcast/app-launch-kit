# Building Your Own Design System, As You Go

Goal: a distinctive, consistent feel across every app, without designing a
framework upfront (that tends to produce the wrong abstractions before you
know what you actually reuse). This isn't just a pragmatic shortcut —
research into how acclaimed indie apps and the wider design-systems
literature actually work confirms it's the dominant pattern, not a
corner being cut. See `research/design-principles-report.md` for the full,
sourced writeup this section is drawn from.

## Sequencing

1. **Build app #1 with no shared package.** Just ship it.
2. **Build app #2.** As you copy patterns from app #1 (a button style, a
   card layout, a color ramp, a haptic pattern, an onboarding flow shape),
   notice what you're duplicating verbatim.
3. **Extract on the Rule of Three, not the second copy.** Wait for a
   pattern to appear a *third* time — in a third app, or a third place in
   the same app — before pulling it into `TimDeaconKit`. Two copies can't
   tell you whether the similarity is real or coincidental; three
   usually can. This is a slightly sharper trigger than "the moment
   you're about to copy-paste a second time" (the original version of
   this rule) — the extra copy costs little and saves you from
   abstracting the wrong thing. If an extraction turns out wrong once
   you see a third use case that doesn't fit, inline it back into the
   app rather than contorting the shared version — reversing a
   premature abstraction is cheaper than living with it. This is
   exactly how [TimDeaconKit](https://github.com/gustyforcast/TimDeaconKit)
   started — extracted from StillTime's card style, spacing grid, and
   haptics after the fact, not designed before StillTime shipped.
4. **Keep the split clean going forward**: the shared package owns
   mechanism (color composition, light/dark adaptation, spacing/type
   scale as tokens, platform bridging for iOS/macOS differences); each
   app owns its own *vocabulary* — its own token names, its own specific
   palette values — layered on top. The shared package should never
   accumulate an app-specific concept.
5. **Cap it deliberately.** A solo design system stays useful by staying
   small: aim for roughly 15–20 tokens total, only the components you've
   actually reused three-plus times (a dozen or so, not a hypothetical
   full catalog), and documentation capped at about three lines per
   component (why it exists, when not to use it, known exceptions) —
   docs like this get scanned, not read. Code is the source of truth:
   if a component's real usage drifts from its doc, fix the doc, not
   the other way round. This is deliberately leaner than an
   enterprise design-system team's output — you don't have one, and you
   don't need one.

## Structure to copy

A good reference shape (see
[danielbyon/swift-design-system](https://github.com/danielbyon/swift-design-system)
and [dskit-swiftui](https://github.com/imodeveloper/dskit-swiftui) for two
real examples of this pattern):

```
TimDeaconKit/                     ← Swift Package, one product module
  Sources/TimDeaconKit/
    Tokens/                      ← spacing, radius, type scale, motion durations
    Color/                       ← color composition + light/dark adaptation
    Components/                  ← buttons, cards, sheets, nav chrome — the
                                    "distinctive feel" primitives
    Platform/                    ← iOS/macOS bridging where SwiftUI diverges
  Sources/TimDeaconKitTestSupport/ ← public test-only helpers
  Tests/
```

Each app then defines its own finite token *values* (its own enum cases,
its own specific hex/HSB values) that plug into the shared machinery —
compiler-checked symbols, not strings, so a typo or missing token is
caught at build time, not at runtime.

## A catalog app pays for itself fast

Once the package exists, add a small "Explorer" target inside it — a
catalog app with one screen per component, showing it with real data.
This becomes:

- Your own visual reference when starting a new app (copy a whole section
  wholesale, per your original goal).
- A place Claude can `Read` before guessing at an API or reinventing a
  component that already exists — point Claude at the Explorer's source
  before it writes new UI in an app.

## What "copy large sections of different apps" looks like in practice

Once `TimDeaconKit` exists, a new app's first build session should:

1. Read the Explorer catalog to see what already exists.
2. Compose the new screen almost entirely from existing components.
3. Only write new SwiftUI where the screen genuinely needs something the
   kit doesn't have yet — and when it does, ask: does this belong in the
   app, or does it belong back in the kit?

That question, asked every time, is what keeps the "distinctive feel"
compounding instead of forking into N slightly-different look-and-feels
across your apps.

## What actually distinguishes well-regarded indie apps

Not comprehensive polish — one structuring idea, executed with restraint.
Flighty's entire UI is organized around an airport departure board.
CARROT Weather is explicitly two apps in one (an "entertainment app" and
a "professional weather app") behind a single toggle. Copilot Money's
"unique look and feel" comes from deeply customizing native UIKit
components, not building bespoke UI or importing a generic component
kit — which also made their bugs easier to find, since there was less
custom code to debug. Overcast's redesign swapped San Francisco for SF
Rounded specifically because it served both legibility *and* the app's
personality at once — a good design decision is usually justified on
function and feeling simultaneously, not one or the other. When you're
evaluating your own screen, ask: what's the one idea this screen is
built around, and am I customizing something native or reinventing it?

## A study sequence, not just a build sequence

The same "foundations before components" pattern that governs when to
extract code into `TimDeaconKit` also governs what to actually learn, and
it isn't a house style — Apple's HIG, Google's Material Design 3, and the
Laws of UX / Refactoring UI tradition all independently converge on it:

1. **Foundations first**: accessibility (WCAG's POUR principles —
   Perceivable, Operable, Understandable, Robust), an 8pt spacing grid, a
   modular type scale (one base size, a consistent ratio like 1.2–1.333),
   and a systematic color ramp (a full tint/shade range per color,
   checked against WCAG contrast minimums) — before any component work.
   Accessibility fixes tend to be general usability fixes in disguise: a
   contrast ratio that helps low vision also helps you in sunlight; a
   larger tap target that helps motor impairment also helps you
   one-handed on a train.
2. **The psychology, as the "why"**: the five highest-leverage Laws of UX
   are worth actually knowing — Jakob's Law (people want your app to work
   like the ones they already know), Fitts's Law and Hick's Law (target
   size/distance and choice count both cost time), Miller's Law (chunk
   information into ~7±2 groups), and the Aesthetic-Usability Effect (a
   more attractive interface is perceived as more usable, independent of
   whether it actually is).
3. **Refactoring UI as the execution playbook**: the tactical rules a
   non-designer can just apply — build hierarchy through size/weight/color
   rather than borders, use fewer borders generally (whitespace or a
   subtle background shift instead), pick one consistent light source for
   shadows, work in HSL so you can generate a full shade range per color.
4. **Nielsen Norman Group's 10 heuristics as a post-hoc audit**: run a
   finished screen against these rather than designing from them —
   visibility of system status, match with the real world, user control
   and freedom, consistency, error prevention, recognition over recall,
   flexibility, minimalist aesthetics, error recovery, help/documentation.

Think → execute → audit. Full detail and sources for all of the above:
`research/design-principles-report.md`.

## Where to keep learning

A few of the sources that used to anchor "how indie iOS devs learn
design" have gone quiet — Under the Radar (Marco Arment & David Smith's
podcast) ended in Nov 2025, and Sebastiaan de With (Halide) joined
Apple's internal design team in Jan 2026, so his independent output is
now a closed archive, not an ongoing feed. Confirmed still-active as of
this writing:

- **Apple's WWDC Design track** (developer.apple.com/design) — the single
  most reliable, primary, non-content-farm source found; WWDC26 has a
  session literally titled "Principles of great design."
- **Sidebar** (sidebar.io) — a daily five-link design newsletter, still
  active under UX Collective.
- **Khoi Vinh's Subtraction.com** and **Craig Mod's essay site**
  (craigmod.com/essays) — long-running personal blogs with deep,
  design-and-craft-focused archives.
- **Steve Schoger** (co-author, Refactoring UI) — still active on X,
  has teased further work with Adam Wathan.

Treat any other "best design resources" list — including this one — as
due for periodic re-verification rather than permanent. Sources in this
space go stale faster than the principles do.
