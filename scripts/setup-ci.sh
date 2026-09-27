#!/usr/bin/env bash
# Drop the app-launch-kit CI workflows into an EXISTING app repo that
# wasn't created with new-project.sh (e.g. an older project you're
# retrofitting this pipeline onto).
#
# Usage:
#   ./scripts/setup-ci.sh <AppName> <path-to-existing-repo>

set -euo pipefail

KIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

APP_NAME="${1:?Usage: setup-ci.sh <AppName> <path-to-existing-repo>}"
TARGET_DIR="${2:?Usage: setup-ci.sh <AppName> <path-to-existing-repo>}"

if [ ! -d "$TARGET_DIR/.git" ]; then
  echo "Error: $TARGET_DIR doesn't look like a git repo (no .git dir)." >&2
  exit 1
fi

mkdir -p "$TARGET_DIR/.github/workflows"

sed "s/__APP_NAME__/$APP_NAME/g" "$KIT_DIR/.github/workflows/build-and-testflight.yml" \
  > "$TARGET_DIR/.github/workflows/build-and-testflight.yml"
cp "$KIT_DIR/.github/workflows/ci-logic-tests.yml" "$TARGET_DIR/.github/workflows/ci-logic-tests.yml"

echo "CI workflows copied into $TARGET_DIR/.github/workflows/"
echo ""
echo "Before this does anything useful:"
echo "  1. Edit build-and-testflight.yml — check SCHEME/PROJECT match your actual Xcode project."
echo "  2. If you don't have a Swift Package target for logic tests, delete ci-logic-tests.yml"
echo "     or point it at a package elsewhere in the repo."
echo "  3. Add the signing secrets listed at the top of build-and-testflight.yml before"
echo "     pushing a version tag (git tag v1.0.0 && git push --tags)."
echo "  4. Commit and push: git -C \"$TARGET_DIR\" add .github && git -C \"$TARGET_DIR\" commit -m 'Add CI'"
