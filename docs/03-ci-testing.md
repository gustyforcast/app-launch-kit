# CI & Automated Testing

Two workflows, split by cost (see `docs/01-tool-stack-and-costs.md` for
why macOS runner minutes are expensive). Templates are in
`.github/workflows/` and get copied into a new app repo by
`scripts/setup-ci.sh`.

## `ci-logic-tests.yml` — runs on every push, Linux, cheap

Runs `swift test` against any target that doesn't import UIKit/SwiftUI/
AppKit — your models, view models (if platform-agnostic), business logic,
and the design-system package's non-UI pieces. This is what should catch
most regressions, most of the time, for close to free.

## `build-and-testflight.yml` — runs on PRs into `main` and version tags, macOS

The expensive job. Structure:

1. Checkout on `macos-latest` (or pin a specific Xcode version).
2. Resolve Swift Package dependencies.
3. `xcodebuild build-for-testing` on an iOS Simulator destination — this
   is your real UI-layer compile check.
4. `xcodebuild test-without-building` against that simulator build.
5. **Only on a version tag**: archive, export a signed `.ipa` using
   secrets for the signing certificate / provisioning profile /
   App Store Connect API key, and upload straight to TestFlight via
   `xcrun altool` or `fastlane pilot`. This "push a tag → TestFlight build
   appears" pattern is a proven, Mac-free release pipeline used by
   multiple solo iOS developers.

Keep the signing material as encrypted GitHub Actions secrets, never
committed. App Store Connect API keys (not your personal Apple ID) are the
right credential for CI.

## Verifying "done" mechanically, not by self-report

A build isn't finished because Claude says it's finished. Before closing
out a `tasks.md` item:

1. CI is green on the PR (both workflows).
2. If the task touched UI, a screenshot or simulator interaction confirms
   it visually — either through an on-device Claude Code session with
   XcodeBuildMCP, or the `ios-simulator-skill` if you're doing this from a
   cloud session with device access.
3. The task's entry in `tasks.md` is checked off in the same commit.

## If you want Claude driving the simulator directly

That needs an actual Mac in the loop — either this app's device bridge
pointed at your own Mac, or an on-device Claude Code session with
XcodeBuildMCP installed (`scripts/install-claude-tools.sh` does this).
Cloud-only sessions can write the test code but can't watch it run.
