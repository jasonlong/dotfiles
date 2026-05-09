# Personal app-bb setup

- app-bb runs locally at `http://app.pscaledev.com:3001/`.
- When asked to inspect app-bb in a browser, use browser-tools against `http://app.pscaledev.com:3001/` unless the user provides a different URL or route.
- For route-specific browser checks, append the route path to that base URL.
- In dev browser checks, prefer `~/dev/dotfiles/pi/projects/app-bb/scripts/open-route.js <route-or-url>` to open routes. It starts browser-tools, handles the dev login screen, and re-opens the requested route after auth.
- For responsive checks, use `~/dev/dotfiles/pi/projects/app-bb/scripts/check-breakpoints.js <route-or-url>`. Screenshots are opt-in with `--screenshots` because Chromium screenshot capture can be slow on some app pages.
- If manually using browser-tools, use a fresh browser first instead of `--profile`. The auth app may show a login screen; the username/password are pre-filled in dev mode, so click the submit/sign-in button to continue. Do not combine the login click and post-login waiting in one browser eval because navigation can destroy the eval context.
