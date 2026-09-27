#!/usr/bin/env bash
# Registers the recommended MCP servers/skills for Swift/iOS work with
# Claude Code, and prints the manual step for the one Claude Code skill
# that isn't installed via `claude mcp add`.
#
# Run this ON-DEVICE (a Mac with Xcode installed and Claude Code's `claude`
# CLI on PATH) — MobileBuildMCP needs the real Xcode toolchain to be useful,
# so running it from a cloud/Linux session has nothing to attach to.
#
# See docs/01-tool-stack-and-costs.md for what each of these does.

set -euo pipefail

if ! command -v claude >/dev/null 2>&1; then
  echo "Error: 'claude' CLI not found on PATH. Install Claude Code first:" >&2
  echo "  https://claude.com/claude-code" >&2
  exit 1
fi

echo "== Installing MobileBuildMCP (formerly XcodeBuildMCP) =="
# Package/repo were renamed in 2026 (getsentry/XcodeBuildMCP ->
# getsentry/MobileBuildMCP, npm package xcodebuildmcp -> mobilebuildmcp).
# The v2.7.1 rename release also renamed the env var prefix
# (XCODEBUILDMCP_* -> MOBILEBUILDMCP_*), the state dir
# (~/Library/Developer/XcodeBuildMCP -> .../MobileBuildMCP), and the project
# config dir (.xcodebuildmcp/ -> .mobilebuildmcp/). Confirmed against the
# v2.7.1 release notes: https://github.com/getsentry/MobileBuildMCP/releases/tag/v2.7.1
claude mcp add -s user MobileBuildMCP npx mobilebuildmcp@latest \
  -e INCREMENTAL_BUILDS_ENABLED=true \
  -e MOBILEBUILDMCP_ENABLED_WORKFLOWS="simulator,device,project-discovery,session-management" \
  -e MOBILEBUILDMCP_SENTRY_DISABLED=true

echo ""
echo "== ios-simulator-skill =="
echo "Distributed as a Claude Code plugin — install from within Claude Code:"
echo "  /plugin marketplace add conorluddy/ios-simulator-skill"
echo "  /plugin install ios-simulator-skill@conorluddy"
echo "(Manual clone still works if you'd rather not use the marketplace —"
echo "see the repo's own README, layout may change:"
echo "  https://github.com/conorluddy/ios-simulator-skill )"
echo "Requires Xcode + Command Line Tools 26+ on this Mac (xcode-select --install)."

echo ""
echo "== vexp (optional, local context engine) =="
read -rp "Install vexp CLI now via npm? [y/N] " REPLY
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
  npm install -g vexp-cli
  echo "Run 'vexp-core mcp --workspace .' inside a project to index it, or"
  echo "use 'workspace_setup' from within a Claude Code session once it's registered."
else
  echo "Skipped. Install later: npm install -g vexp-cli   (https://vexp.dev)"
fi

echo ""
echo "Done. Restart Claude Code for the new MCP server to take effect."
