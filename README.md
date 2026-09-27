# app-launch-kit

A repeatable, low-token, low-cost pipeline for taking a Swift (iOS/macOS)
app idea from a rough discussion to a sustaining product — using Claude
Code for the writing/refactoring work and GitHub Actions macOS runners for
the parts that actually need Xcode.

This repo is the **toolkit**, not an app. Each real app gets its own repo
(private, if it might earn money) built by running `scripts/new-project.sh`
against this kit.

## The pipeline

```
Decision discussion  →  spec.md  →  plan.md  →  tasks.md  →  build
        │                                                      │
        ▼                                                      ▼
   research links                                    automated testing (CI)
        │                                                      │
        ▼                                                      ▼
  marketing-plan.md  ←───────────  functional build  ────►  roadmap.md
        │
        ▼
     launch → revenue tracking → next roadmap cycle
```

Every stage is a markdown file (or a CI workflow) that lives in the app's
own repo, seeded from the templates here. Nothing here is a framework you
install — it's a starting point you copy and adapt per app.

## Layout

| Path | What it's for |
|---|---|
| `docs/00-overview-and-workflow.md` | The full process this kit assumes, stage by stage |
| `docs/01-tool-stack-and-costs.md` | Claude Code + GitHub Pro + MCP servers, what each costs, when to use which |
| `docs/02-design-system-guide.md` | How to grow your own reusable SwiftUI design system across apps |
| `docs/03-ci-testing.md` | GitHub Actions setup for Swift — logic tests on Linux, builds on macOS, kept cheap |
| `docs/04-marketing-and-launch.md` | Launch checklist and channel priority for a near-zero marketing budget |
| `docs/05-monetization-and-roadmap.md` | Revenue tooling, realistic benchmarks, portfolio strategy, roadmap cadence |
| `templates/` | Blank spec, plan, tasks, marketing-plan, roadmap, and an XcodeGen `project.yml` |
| `scripts/new-project.sh` | Scaffolds a new app repo from the templates |
| `scripts/setup-ci.sh` | Drops the CI workflows into an existing app repo |
| `scripts/install-claude-tools.sh` | Registers the recommended MCP servers with Claude Code |
| `.github/workflows/` | The two CI templates themselves (Linux logic tests, macOS build/TestFlight) |
| `CLAUDE.md` | Root instructions Claude Code reads automatically in any repo built from this kit |

## Quick start

```bash
git clone https://github.com/gustyforcast/app-launch-kit.git
cd app-launch-kit
./scripts/new-project.sh MyNewApp ios
cd ../MyNewApp
```

That gives you a fresh folder with `docs/spec.md` ready to fill in, a
Swift Package skeleton, an XcodeGen `project.yml`, CI workflows already
wired up, and a `CLAUDE.md` telling Claude Code how this project expects
to be worked on. Push it to a new (private, if it's a money app) GitHub
repo and start the decision discussion in `docs/spec.md`.

## Why this shape

- **Git/cloud Claude Code sessions** (no local Mac needed) do the spec
  writing, refactors, and cross-file Swift work — cheap and fast to run.
- **A macOS GitHub Actions runner**, triggered by a push, does the one
  thing that actually needs Xcode: build, test-on-simulator, archive, and
  upload to TestFlight. macOS runner minutes cost ~10x Linux minutes, so
  the logic-only tests run on Linux and the expensive macOS job is
  reserved for PRs into `main` and release tags — see
  `docs/03-ci-testing.md` for the exact split.
- **A shared design-system package** (see `docs/02-design-system-guide.md`)
  is grown *from* your first two apps rather than designed upfront, so it
  never accumulates the wrong abstractions.
- **Every stage is a markdown file Claude can read, extend and be graded
  against** — the spec is the source of truth; code and tests are outputs
  of it, not the other way around.

See `docs/00-overview-and-workflow.md` for the full walkthrough.
