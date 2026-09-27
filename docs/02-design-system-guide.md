# Building Your Own Design System, As You Go

Goal: a distinctive, consistent feel across every app, without designing a
framework upfront (that tends to produce the wrong abstractions before you
know what you actually reuse).

## Sequencing

1. **Build app #1 with no shared package.** Just ship it.
2. **Build app #2.** As you copy patterns from app #1 (a button style, a
   card layout, a color ramp, a haptic pattern, an onboarding flow shape),
   notice what you're duplicating verbatim.
3. **Extract, don't design.** Pull the duplicated pieces into a Swift
   Package — call it `<YourName>Kit` — the first time you're about to
   copy-paste the same SwiftUI view or modifier a second time.
4. **Keep the split clean going forward**: the shared package owns
   mechanism (color composition, light/dark adaptation, spacing/type
   scale as tokens, platform bridging for iOS/macOS differences); each
   app owns its own *vocabulary* — its own token names, its own specific
   palette values — layered on top. The shared package should never
   accumulate an app-specific concept.

## Structure to copy

A good reference shape (see
[danielbyon/swift-design-system](https://github.com/danielbyon/swift-design-system)
and [dskit-swiftui](https://github.com/imodeveloper/dskit-swiftui) for two
real examples of this pattern):

```
YourNameKit/                     ← Swift Package, one product module
  Sources/YourNameKit/
    Tokens/                      ← spacing, radius, type scale, motion durations
    Color/                       ← color composition + light/dark adaptation
    Components/                  ← buttons, cards, sheets, nav chrome — the
                                    "distinctive feel" primitives
    Platform/                    ← iOS/macOS bridging where SwiftUI diverges
  Sources/YourNameKitTestSupport/ ← public test-only helpers
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

Once `YourNameKit` exists, a new app's first build session should:

1. Read the Explorer catalog to see what already exists.
2. Compose the new screen almost entirely from existing components.
3. Only write new SwiftUI where the screen genuinely needs something the
   kit doesn't have yet — and when it does, ask: does this belong in the
   app, or does it belong back in the kit?

That question, asked every time, is what keeps the "distinctive feel"
compounding instead of forking into N slightly-different look-and-feels
across your apps.
