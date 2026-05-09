---
name: precommit
description: Prepare app-bb UI/frontend changes for commit by running formatting/lint/type checks, fixing issues, and performing a final UI review against design-system and web-design guidelines.
argument-hint: [optional-file-or-diff-scope]
---

# Precommit

You are preparing app-bb UI/frontend changes for commit. The goal is to leave the working tree in a state that passes project checks and has had a focused UI/design/accessibility review.

## Local App URL

app-bb runs locally at `http://app.pscaledev.com:3001/`. When browser inspection is needed, open that base URL unless the user provides a different URL or route.

Prefer `~/dev/dotfiles/pi/projects/app-bb/scripts/open-route.js <route-or-url>` for browser checks. It starts browser-tools, handles the dev login screen, and re-opens the requested route after auth.

If manually using browser-tools, use a fresh browser first instead of `--profile`. The auth app may show a login screen; the username/password are pre-filled in dev mode, so click the submit/sign-in button to continue. Do not combine the login click and post-login waiting in one browser eval because navigation can destroy the eval context.

## Route Finder Convention

When browser inspection is requested but no route is provided:

1. Infer the likely route from changed files, route filenames, links, tests, story names, or nearby page usage.
2. If exactly one route is likely, use it and state the assumption.
3. If multiple routes are plausible, ask one concise clarification question instead of guessing.
4. Build the URL from `http://app.pscaledev.com:3001/` plus the route path.

## Process

1. Identify changed files:
   - Run `git status --short`.
   - Inspect `git diff --stat` and `git diff --name-only`.
   - Include untracked frontend files when relevant.
2. Read project guidance:
   - `AGENTS.md`
   - `DESIGN.md` when UI/styling files changed.
3. Run checks in the project-recommended order:
   - `npm run lint:fix`
   - `npm run stylelint`
   - `npm run tsc`
4. Fix issues from those commands.
   - Use minimal, targeted edits.
   - Re-run the failing command after fixes.
   - Do not claim a command passed unless it actually passed.
5. Perform a final UI review using `/skill:review` expectations:
   - Bugs and regressions
   - Accessibility and Web Interface Guidelines
   - Unnecessary complexity
   - `AGENTS.md` adherence
   - `DESIGN.md` spacing, colors, typography, components, and copywriting
6. Summarize:
   - Commands run and final status
   - Files changed by fixes
   - Remaining risks or follow-ups, if any

## Guardrails

- Do not commit unless the user explicitly asks.
- Do not run broad unrelated refactors.
- Do not hide failures. If a command fails because of pre-existing unrelated issues, state that clearly with evidence.
- Prefer existing app-bb patterns over introducing new helpers or abstractions.
