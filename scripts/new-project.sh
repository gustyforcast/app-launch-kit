#!/usr/bin/env bash
# Scaffold a new app project from the app-launch-kit templates.
#
# Usage:
#   ./scripts/new-project.sh <AppName> [ios|macos|multiplatform] [destination-dir]
#
# Creates ../<AppName> (or <destination-dir>) by default — a sibling of
# this kit — with:
#   - docs/spec.md, plan.md, tasks.md, marketing-plan.md, roadmap.md (from templates/)
#   - a Swift Package skeleton for logic/tests (works without Xcode)
#   - project.yml (XcodeGen) with placeholders filled in
#   - .github/workflows/ (CI templates, placeholders filled in)
#   - CLAUDE.md (from this kit's root CLAUDE.md, app name substituted)
#   - a git repo, initialized and committed
#
# Requires: bash, git. Does NOT require Xcode — this can run in a
# cloud/Linux Claude Code session. Run `xcodegen generate` later, on a Mac,
# to produce the actual .xcodeproj.

set -euo pipefail

KIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

APP_NAME="${1:?Usage: new-project.sh <AppName> [ios|macos|multiplatform] [destination-dir]}"
PLATFORM="${2:-ios}"
DEST_DIR="${3:-$KIT_DIR/../$APP_NAME}"

APP_NAME_LOWER=$(echo "$APP_NAME" | tr '[:upper:]' '[:lower:]')

if [ -e "$DEST_DIR" ]; then
  echo "Error: $DEST_DIR already exists." >&2
  exit 1
fi

echo "Scaffolding $APP_NAME ($PLATFORM) at $DEST_DIR ..."

mkdir -p "$DEST_DIR"/{docs,Sources/"$APP_NAME",Tests/"$APP_NAME"Tests,.github/workflows}

# --- docs, from templates, with the app name substituted ---
for tmpl in spec plan tasks marketing-plan roadmap; do
  sed "s/<App Name>/$APP_NAME/g" "$KIT_DIR/templates/$tmpl.md" > "$DEST_DIR/docs/$tmpl.md"
done

# --- XcodeGen project.yml ---
sed \
  -e "s/__APP_NAME__/$APP_NAME/g" \
  -e "s/__APP_NAME_LOWER__/$APP_NAME_LOWER/g" \
  "$KIT_DIR/templates/project.yml" > "$DEST_DIR/project.yml"

# --- CI workflows ---
sed "s/__APP_NAME__/$APP_NAME/g" "$KIT_DIR/.github/workflows/build-and-testflight.yml" \
  > "$DEST_DIR/.github/workflows/build-and-testflight.yml"
cp "$KIT_DIR/.github/workflows/ci-logic-tests.yml" "$DEST_DIR/.github/workflows/ci-logic-tests.yml"

# --- minimal Swift Package skeleton (logic + tests, no Xcode needed to create it) ---
cat > "$DEST_DIR/Package.swift" <<EOF
// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "$APP_NAME",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(name: "$APP_NAME", targets: ["$APP_NAME"])
    ],
    targets: [
        .target(name: "$APP_NAME"),
        .testTarget(name: "${APP_NAME}Tests", dependencies: ["$APP_NAME"])
    ]
)
EOF

cat > "$DEST_DIR/Sources/$APP_NAME/$APP_NAME.swift" <<EOF
// Logic lives here — anything importing SwiftUI/UIKit goes in an Xcode
// target once project.yml is generated (\`xcodegen generate\` on a Mac),
// not in this package target, so \`swift test\` keeps running on Linux CI.
EOF

cat > "$DEST_DIR/Tests/${APP_NAME}Tests/${APP_NAME}Tests.swift" <<EOF
import Testing
@testable import $APP_NAME

@Test func placeholder() {
    #expect(true)
}
EOF

# --- CLAUDE.md ---
sed "s/<App Name>/$APP_NAME/g; s/<PLATFORM>/$PLATFORM/g" "$KIT_DIR/CLAUDE.md" > "$DEST_DIR/CLAUDE.md"

# --- .gitignore ---
cat > "$DEST_DIR/.gitignore" <<'EOF'
.build/
.swiftpm/
*.xcodeproj/
xcuserdata/
DerivedData/
.DS_Store
*.ipa
*.p12
*.mobileprovision
ExportOptions.plist
EOF

# --- README pointing back at the kit ---
cat > "$DEST_DIR/README.md" <<EOF
# $APP_NAME

Built from [app-launch-kit](https://github.com/gustyforcast/app-launch-kit).
Start in \`docs/spec.md\`. See the kit's \`docs/00-overview-and-workflow.md\`
for the full process this repo follows.

Platform: $PLATFORM
EOF

# --- git init + first commit ---
git -C "$DEST_DIR" init -q
git -C "$DEST_DIR" add -A
git -C "$DEST_DIR" commit -q -m "Scaffold $APP_NAME from app-launch-kit"

echo ""
echo "Done. $DEST_DIR is ready:"
echo "  - docs/spec.md      ← start the decision discussion here"
echo "  - project.yml       ← run 'xcodegen generate' on a Mac to produce the .xcodeproj"
echo "  - .github/workflows ← CI wired up, fill in signing secrets before tagging a release"
echo ""
echo "Next: create a GitHub repo for it (private if it may earn money) and push."
