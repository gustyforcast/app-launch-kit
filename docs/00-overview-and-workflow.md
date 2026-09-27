# Overview & Workflow

This is spec-driven development (SDD), scoped down to what one person
building Swift apps with Claude actually needs — closest in spirit to
[GitHub Spec Kit](https://github.com/github/spec-kit) rather than a
heavier multi-agent framework like BMAD-METHOD. The heavier frameworks
produce more thorough documentation but the coordination overhead outweighs
the benefit at solo, rapid-iteration scale.

## The five stages

### 1. Decision discussion → `docs/spec.md`

Have the open-ended argument with Claude first: what is this app, who is
it for, what does it explicitly *not* do, what's the distinctive feel.
Link in research (competitor apps, App Store category gaps, relevant
technical constraints) as you go. Don't write code yet — the goal is a
frozen `spec.md` that states the *what* and *why*, no implementation
detail. Use `templates/spec.md`.

**Validate before moving on**: read the spec back and ask "does this
disagree with itself anywhere?" Ambiguous or self-contradictory specs are
where expensive rework starts — catch it here, not mid-build.

### 2. Plan → `docs/plan.md`

Translate the spec into the technical *how*: architecture, module
boundaries, which parts of your shared design-system package this app
will use vs. extend, data model, third-party dependencies (RevenueCat,
etc.), and a call on git/cloud vs. on-device for each piece of work (see
`docs/01-tool-stack-and-costs.md`). Use `templates/plan.md`.

### 3. Tasks → build

Break the plan into ordered, testable tasks (`templates/tasks.md`). This
is the actual build loop: each task is small enough to be one Claude Code
session, reviewable as a diff, and it references back to the spec section
it satisfies. Traceability both ways — task → spec, spec → task — is what
keeps a long-running solo project from drifting.

Run these sessions as git/cloud Claude Code wherever possible. Only fall
back to an on-device or CI-driven build step when the task needs Xcode
itself (see the tool-stack doc).

### 4. Automated testing

Once a task produces something functional, it isn't "done" until CI says
so — mechanical verification, not a model's self-report. See
`docs/03-ci-testing.md` for the actual GitHub Actions setup. Logic tests
run on every push (cheap, Linux); simulator/build verification runs on
PRs into `main` and on release tags (the expensive macOS job).

### 5. Marketing & release plan → `docs/marketing-plan.md`

Once the build is functional and tested, write the launch plan *before*
you launch — channel priority, ASO keywords, screenshot plan, launch-week
comms, and an honest revenue expectation over the following months, built
from real base rates rather than hope. See
`docs/04-marketing-and-launch.md` and `docs/05-monetization-and-roadmap.md`.
Use `templates/marketing-plan.md`.

### 6. Roadmap → `docs/roadmap.md`

Once the app is live and earning (or clearly not), turn what you learned
into the next spec cycle. The roadmap is just a living list of future
spec.md candidates, prioritized by what the revenue/usage data actually
showed you — not a separate PM tool. Use `templates/roadmap.md`.

## The loop, visually

```
spec.md ──► plan.md ──► tasks.md ──► [build session] ──► CI green?
   ▲                                                         │
   │                                                         ▼
roadmap.md ◄── revenue/usage data ◄── launch ◄── marketing-plan.md
```

## Working across sessions without losing context

- Keep `spec.md`, `plan.md`, `tasks.md` as the durable memory of the
  project — a fresh Claude Code session should be able to read these
  three files and know exactly where the project is, without you
  re-explaining anything.
- Keep the root `CLAUDE.md` short (see `docs/01-tool-stack-and-costs.md`
  on token cost) — it should point at these docs, not duplicate them.
- Close out a task by updating `tasks.md`'s checklist and committing it in
  the same commit as the code — the task list is the project's changelog.
