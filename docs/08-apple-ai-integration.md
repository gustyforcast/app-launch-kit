# Where Apple's Own Guidance Meets AI-Assisted Development

Two separate things worth keeping straight: (1) how Apple wants *your app*
to use AI (generative features, on-device intelligence, system integration),
and (2) how Apple's App Store review treats apps that were *built with* AI
coding tools. Neither is the same question as the design language in
`docs/02-design-system-guide.md`, but the first feeds directly into it —
Apple's own generative-AI interface patterns are part of "the Apple feel"
alongside its established HIG conventions (SF Symbols, nav bars, grouped
lists, Dynamic Type).

## 1. Designing AI features the Apple way (HIG: Generative AI)

Apple's HIG has a dedicated "Generative AI" section
([developer.apple.com/design/human-interface-guidelines/generative-ai](https://developer.apple.com/design/human-interface-guidelines/generative-ai)).
The page itself is JS-rendered and not fully scrapable, but the framing
Apple gives it is explicit: generative AI should "enhance your app... with
dynamic content and intelligent features," not be the app's whole identity.
In practice, across Apple's HIG philosophy and its WWDC guidance on Apple
Intelligence-adjacent features, the recurring principles are:

- **AI output is a layer on top of a real app**, not a replacement UI —
  it should sit inside the same navigation, typography and controls as the
  rest of the app, not spawn a separate "chat mode" that looks unrelated.
- **Show your work state honestly** — a generating/thinking state should be
  visibly distinct from a finished result, so the user is never unsure
  whether what they're looking at is final.
- **User stays in control** — AI suggestions are proposed, not applied
  silently; destructive or hard-to-reverse actions need explicit
  confirmation, same as any other iOS affordance.
- **Errors and low-confidence output are surfaced, not hidden** — a
  wrong-but-confident-looking answer is worse than a visible "not sure"
  state.

For the kit: any app that adds an AI feature (e.g. StillTime's insight
generator) should keep that feature visually native — same card/list/type
system as the rest of the app — rather than styling it as a distinct
"AI product" bolted on.

## 2. App Intents — making an app's actions AI/Siri/Spotlight-visible

The App Intents framework
([developer.apple.com/documentation/appintents](https://developer.apple.com/documentation/appintents))
is the actual mechanism for "linking with AI development" on Apple's
platforms. It's not about calling an LLM from your app — it's about
exposing your app's actions and content to the system so Siri, Spotlight,
Shortcuts, and Apple Intelligence's system-level features can discover and
invoke them without the user opening the app.

What it takes to adopt:
1. Define `AppIntent` conformances for the app's key actions (start a
   session, log an entry, create a note — whatever the app's core verbs
   are).
2. Expose relevant content via `AppEntity`/`IndexedEntity` so it's
   searchable in Spotlight and referenceable by Siri.
3. Nothing here requires bringing your own model or API key — it's a
   system integration point, distinct from the drawing-app's own use of
   generative content.

WWDC 2026 added further capabilities in this area (session "Discover new
capabilities in the App Intents framework," WWDC26). Worth revisiting once
an app has a stable enough core action to expose — e.g. StillTime's "start
a focus session" is a natural App Intent candidate, and Verso's "find
photos like this" could become a Spotlight-searchable entity.

This is genuinely free reach: adopting it costs no external services and
directly serves the no-capital-investment ideology in
`docs/06-bootstrap-ideology-and-tools.md` — it's discovery, not
acquisition spend.

## 3. App Store review and AI-built apps

Apple tightened App Review Guideline 4.3 (Spam) in June 2026
([MacRumors coverage](https://www.macrumors.com/2026/06/09/app-store-guidelines-low-quality-apps/);
primary source: [App Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)).
The change doesn't call out "AI-generated code" by name — it targets
low-effort, templated, or oversaturated-category apps generally (already-
saturated categories like flashlight/timer/wallpaper apps face stricter
scrutiny; generic variants of existing popular apps can be rejected outright
for lacking a "meaningfully different or improved experience").

The practical read for this kit: **the risk isn't "built with Claude," it's
"looks like every other app in the category."** This is actually the same
problem `docs/02-design-system-guide.md` and this design-language work are
already solving — a distinctive, source-grounded visual identity (not a
generic AI-tool default look) is now also an App Review risk mitigation,
not just a brand nicety. No process change needed here beyond what's
already in motion; noting the connection so it isn't lost.

## Where this lands in the kit

- No changes to `docs/06` ideology — App Intents is a discovery channel,
  not a monetization one, and costs nothing.
- Candidate addition to `templates/tasks.md` for any new app: an "App
  Intents" line item once the app's core action is stable enough to expose.
- Candidate addition to `docs/02-design-system-guide.md`: a short "when an
  app has an AI feature" note pointing back to §1 above, once TimDeaconKit
  has an app that actually uses one.

Sources:
- [Generative AI — Apple HIG](https://developer.apple.com/design/human-interface-guidelines/generative-ai)
- [Getting started with the App Intents framework](https://developer.apple.com/documentation/appintents/getting-started-with-the-app-intents-framework)
- [App Intents — Apple Developer Documentation](https://developer.apple.com/documentation/appintents)
- [Discover new capabilities in the App Intents framework — WWDC26](https://developer.apple.com/videos/play/wwdc2026/345/)
- [App Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)
- [Apple Updates App Store Guidelines With Stricter Rules for Low-Quality Apps — MacRumors](https://www.macrumors.com/2026/06/09/app-store-guidelines-low-quality-apps/)
