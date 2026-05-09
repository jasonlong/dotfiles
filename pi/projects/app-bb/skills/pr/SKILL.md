---
name: pr
description: Create GitHub pull requests for app-bb using gh with the user's preferred title/body style. Use when the user asks to open, create, draft, or prepare a PR.
argument-hint: [optional-base-branch-or-issue]
---

# PR

Create GitHub pull requests for app-bb using `gh` and the user's preferred PR style.

## User Preferences

- Use `gh pr create`.
- Always create PRs as drafts.
- Do not add reviewers by default.
- Do not add labels or assignees unless the user explicitly asks.
- Title style: concise, plain English, imperative-ish.
  - Good: `Add branch settings empty state`
  - Avoid noisy prefixes unless the user asks.
- Body style:
  - Do **not** include a `Summary` heading.
  - Start with a few plain, clear sentences describing what changed.
  - If there are multiple interesting pieces, use a short bullet list.
  - Do **not** include a testing section.
  - Do **not** include screenshots; the user will supply screenshots afterwards.
  - Do **not** include a design/accessibility section.
  - If an issue is known, include `Fixes #123` at the end.
  - Keep wording medium-detail, reviewer-friendly, and not overly technical or jargon-heavy.
  - Focus on the novel/user-facing parts of the changes, not routine implementation details.

## Process

1. Inspect branch and changes:
   - `git status --short`
   - `git branch --show-current`
   - `git diff --stat origin/main...HEAD` when appropriate
   - `git log --oneline origin/main...HEAD` when appropriate
2. Check branch hygiene before creating anything:
   - Warn if the working tree has uncommitted changes.
   - Warn if the current branch is `main` or another protected/default-looking branch.
   - Check whether the branch has an upstream with `git rev-parse --abbrev-ref --symbolic-full-name @{u}`.
   - If the branch is not pushed, ask before pushing it.
   - If checks have not been run in the current conversation, mention that and ask whether to proceed anyway.
3. If the base branch is unclear, infer it from repo conventions or ask. Prefer `main` unless evidence says otherwise.
4. Check whether a PR already exists for the branch:
   - `gh pr view --json url,title,isDraft`.
   - If one exists, report the URL instead of creating a duplicate unless the user explicitly asks.
5. Draft the title and body following the preferences above.
6. Show the proposed PR title and body to the user and ask for confirmation before running `gh pr create`.
   - If the user asked only to draft a PR body, stop after showing the draft.
   - If important context is missing, ask before creating the PR.
7. Create the PR as draft after confirmation:
   - `gh pr create --draft --title "..." --body-file <temp-file>`
   - Include `--base <branch>` if needed.
8. Report the PR URL and mention that it was created as draft.

## Body Examples

Simple change:

```md
This adds an empty state to the branch settings page so users have clearer guidance when there is nothing configured yet. The copy explains what to do next and keeps the layout consistent with the rest of the settings experience.
```

Multiple pieces:

```md
This updates the branch settings experience with clearer empty states and more consistent form layout.

- Adds guidance for branches with no configured settings yet.
- Aligns spacing and copy with the existing settings pages.
- Keeps the existing save flow unchanged.

Fixes #123
```
