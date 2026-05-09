# app-bb Pi setup

Personal Pi configuration for `~/dev/app-bb`. These files are versioned here so the team repo can keep `.pi/` gitignored.

## Contents

- `APPEND_SYSTEM.md` — app-bb-specific persistent context, including the local app URL.
- `skills/commit` — creates clean, focused git commits with the preferred message style.
- `skills/pr` — creates draft GitHub PRs with the preferred title/body style.
- `skills/screenshot` — builds UI from screenshots/mockups using app-bb design tokens.
- `skills/review` — reviews frontend changes for bugs, accessibility, complexity, and design-system adherence.
- `skills/precommit` — runs lint/stylelint/tsc and performs a final UI review.

## Linking

`~/dev/dotfiles/link.sh` symlinks these into the app-bb checkout when `~/dev/app-bb` exists:

```txt
~/dev/app-bb/.pi/APPEND_SYSTEM.md -> ~/dev/dotfiles/pi/projects/app-bb/APPEND_SYSTEM.md
~/dev/app-bb/.pi/skills -> ~/dev/dotfiles/pi/projects/app-bb/skills
```

After changing these files while Pi is running, run `/reload` or restart Pi.

## Local app URL

app-bb runs locally at:

```txt
http://app.pscaledev.com:3001/
```

Browser inspections should use that base URL unless a prompt provides a different URL.
