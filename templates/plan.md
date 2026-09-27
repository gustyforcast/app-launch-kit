# Plan: <App Name>

> Stage 2 of the pipeline. Translates `spec.md` into the technical *how*.
> Reference the spec section each decision satisfies.

## Architecture

High-level module breakdown (views, view models, data layer, sync layer).

## Design system usage

- Reused as-is from `YourNameKit`:
- New components needed for this app:
- Anything built here that should probably move *into* `YourNameKit` later:

## Data model

Core entities and relationships. Local storage choice (SwiftData / Core
Data / files) and sync approach if any.

## Dependencies

Third-party packages (RevenueCat, etc.) and why each is needed.

## Where each piece of work happens

| Task area | Cloud Claude Code | On-device / CI |
|---|---|---|
| e.g. data model + view models | ✓ | |
| e.g. SwiftUI screens (visual verify) | draft | ✓ verify |
| e.g. simulator/UI tests | | ✓ |

(See `docs/01-tool-stack-and-costs.md` for the general rule.)

## Testing strategy

What's covered by logic tests (Linux CI) vs. simulator/UI tests (macOS
CI) — see `docs/03-ci-testing.md`.

## Risks / unknowns carried over from the spec's open questions

