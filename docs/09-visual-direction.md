# Visual Direction

This is the "stage 0" document `docs/02-design-system-guide.md` was
missing: a decided aesthetic, arrived at deliberately rather than
inherited from whatever StillTime happened to look like. It exists
because building components before deciding this produces a design
system with no point of view — see the note in `docs/02` on why
sequencing matters.

## How this was decided

Not by picking from a set of generated mockups — that's asking someone
with no design vocabulary to do a designer's synthesis job. Instead:
name real apps whose look you actually respond to, name the specific
words that describe how you want an app to *feel to use* (not just look
in a screenshot), and force the two genuine forks (surface treatment,
color intensity) as direct either/or choices. The answers below are
Tim's, collected 2026-09-28.

| Question | Answer |
|---|---|
| Reference apps that resonate | Things 3 / Fantastical, Flighty / Copilot Money |
| Feel | Precise / technical **and** playful |
| Surface | Soft glass / translucent material |
| Color | Mostly neutral, one accent color |

## What that adds up to

**Not** CARROT's loud, joke-forward personality, and **not** Bear's
stripped-to-nothing minimalism — the reference apps cluster on "native,
polished, quietly confident." Precise/technical + playful together (not
either alone) means: the precision shows up structurally — monospace
numerals, exact grid alignment, an instrument-panel-like layout — and
the playfulness shows up as one small characterful detail, not a whole
loud palette. That resolves last round's flat-hairline-vs-glass fork
directly: **glass is the surface**, and the technical feel comes from
layout and typography discipline on top of it, not from rejecting
material altogether.

Picking "mostly neutral, one accent" also settles something: the
crayon-box multi-swatch motif borrowed from playmusictheory.net's
picker is out. That app's playfulness comes from many flat colors; this
one's playfulness has to come from somewhere else — most likely a
single well-chosen recurring detail (research on Flighty and CARROT
both point at "one memorable hook," not an accumulation of small
delights — see `research/design-principles-report.md`).

## The pillars, concretely

1. **Surface**: `.regularMaterial`-style glass — translucent, blurred,
   layered — as the default card/panel treatment. This is what
   `TimDeaconKit`'s existing `GlassCard` already does; this direction
   validates and keeps it rather than replacing it.
2. **Color**: one accent per app, used sparingly for the single most
   important element on screen (the live/active state, the primary
   action). Everything else stays neutral — off-white/near-black,
   system grays. No secondary or tertiary named colors as a rule.
3. **Type**: system font (SF Pro) for all UI chrome and labels;
   monospace, tabular-figure numerals reserved specifically for data
   readouts (timers, counts, amounts) — never used for labels or
   headings. This is where "precise/technical" actually lives.
4. **Layout**: exact, grid-disciplined spacing (the existing 4/8/12/16/20
   scale), generous whitespace, native list/nav conventions rather than
   invented chrome.
5. **The one hook**: each app should have exactly one distinguishing
   structural idea it's built around — StillTime's is the breathing
   focus ring; a new app needs to name its own before writing
   `spec.md`. This is not "add a fun detail everywhere" — it's "pick
   one thing and let it carry the personality," per the indie-app
   research.

## What's now settled vs. still open

**Settled**: surface (glass), color discipline (one accent), type
discipline (monospace for data only). These apply to every app going
forward and belong in `TimDeaconKit` as-is.

**Still per-app**: the accent color itself, and the "one hook." Those
are vocabulary, not mechanism, per the split in `docs/02` — each app
picks its own.

See the design canvas for the mockup built from this direction
(the "Direction" board) and the four earlier explorations, kept for
reference, marked as explored-not-chosen.
