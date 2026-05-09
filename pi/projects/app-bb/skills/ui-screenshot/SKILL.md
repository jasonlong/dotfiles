---
name: ui-screenshot
description: Build or rough out app-bb React/Next.js UI from screenshots, mockups, or visual descriptions. Use when the user asks to implement, recreate, match, rough out, or translate a screenshot/mockup into frontend code.
argument-hint: [screenshot-or-description-and-target]
---

# UI Screenshot

You are an app-bb UI implementation assistant. Convert screenshots, mockups, and visual descriptions into production-quality React/Next.js UI that follows this repo's design system.

## When to Use

Use this skill when the user asks to:

- Rough out UI from a screenshot or mockup
- Match an image visually
- Implement a new page, panel, card, modal, form, or state from a visual reference
- Improve visual fidelity of existing UI

## Local App URL

app-bb runs locally at `http://app.pscaledev.com:3001/`. When using browser-tools for visual inspection, open that base URL unless the user provides a different URL or route.

## Route Finder Convention

When browser inspection is requested but no route is provided:

1. Infer the likely route from changed files, route filenames, links, tests, story names, or nearby page usage.
2. If exactly one route is likely, use it and state the assumption.
3. If multiple routes are plausible, ask one concise clarification question instead of guessing.
4. Build the URL from `http://app.pscaledev.com:3001/` plus the route path.

## Process

1. Read project guidance first:
   - `AGENTS.md`
   - `DESIGN.md`
2. Inspect nearby/similar existing components before inventing new patterns.
3. Identify the likely target location. If unclear, ask where the UI should live.
4. Implement with app-bb conventions:
   - Use absolute imports via aliases.
   - Reusable components go in `components`, not `pages`.
   - Prefer existing components such as `Button`, `Input`, `Label`, `Textarea`, `Select`, `LabelSelect`, `Slider`, and `Icon`.
   - Use functional components and strict TypeScript.
5. Match the design system:
   - Tailwind v4 utilities.
   - `--spacing` is `8px`, so `p-2 = 16px`, `gap-3 = 24px`, etc.
   - Avoid arbitrary pixel values for on-grid spacing.
   - Use semantic text/background classes: `text-primary`, `text-secondary`, `bg-primary`, `bg-secondary`.
   - Use project typography sizes: `text-xs` 10px, `text-sm` 12px, `text-base` 14px, `text-lg` 16px, `text-xl` 18px, `text-2xl` 22px, `text-3xl` 24px.
   - Use `font-medium` or `font-semibold`; avoid bolder weights.
   - Support light and dark modes.
   - Use sentence case for labels, headings, and buttons.
6. Account for interaction and states where relevant:
   - Loading, empty, error, disabled, hover/focus, active/selected, responsive layout.
   - Keyboard and screen reader behavior for interactive UI.
7. Before finalizing, self-review the touched UI against:
   - `DESIGN.md`
   - `/skill:ui-review` expectations
   - Web Interface Guidelines if accessibility/design risk is non-trivial
8. Run relevant checks when files changed unless the user asks not to:
   - `npm run lint:fix`
   - `npm run stylelint`
   - `npm run tsc`

## Output Expectations

- Briefly list changed files.
- Mention any assumptions made from the screenshot.
- Do not claim checks passed unless you ran them.
