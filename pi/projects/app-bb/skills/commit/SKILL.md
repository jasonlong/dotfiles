---
name: commit
description: Create clean app-bb git commits with the user's preferred concise message style. Use when the user asks to commit changes, split changes into commits, or prepare local commits.
argument-hint: [optional-scope-or-message]
---

# Commit

Create clean git commits for app-bb. Prefer careful staging and logical grouping over committing everything blindly.

## User Preferences

- Commit message titles should be concise, plain English, and imperative-ish.
  - Good: `Add branch settings empty state`
  - Avoid conventional commit prefixes unless the user explicitly asks.
- Keep commits focused on one logical change.
- If there are multiple unrelated changes, propose multiple commits.
- Do not commit without showing what will be included and asking for confirmation.
- Stage only files that belong in the confirmed commit.
- Do not include generated, temporary, or unrelated files unless the user explicitly asks.

## Process

1. Inspect the working tree:
   - `git status --short`
   - `git diff --stat`
   - `git diff --name-only`
   - Read relevant diffs before deciding how to group changes.
2. Decide whether the changes are one logical commit or several.
   - If several, propose commit groups with file lists and messages.
   - If anything looks unrelated or accidental, call it out and leave it unstaged unless confirmed.
3. For frontend/UI changes, check whether `/skill:precommit` has already run in the conversation.
   - If not, ask whether to run it before committing.
   - If the user wants to skip checks, proceed only after they confirm.
4. Show the proposed commit plan:
   - Commit message title
   - Files to stage
   - Any files intentionally left unstaged
5. Ask for confirmation before staging or committing.
6. After confirmation:
   - Stage only the confirmed files.
   - Run `git diff --cached --stat` to verify staged content.
   - Commit with `git commit -m "..."`.
7. Report the resulting commit hash and any remaining unstaged changes.

## Guardrails

- Never use `git add .` unless every changed file was explicitly reviewed and belongs in the same commit.
- Never amend, rebase, reset, or force push unless the user explicitly asks.
- Never claim checks passed unless they were run in this conversation.
- If a commit fails, show the error and do not attempt risky recovery without asking.
