/**
 * Keep Pi in sync with the current OS/terminal appearance.
 *
 * macOS system appearance is preferred because Ghostty is already configured
 * to switch themes with the OS. COLORFGBG is used as a non-macOS fallback when
 * available.
 */

import { execFile } from "node:child_process";
import { promisify } from "node:util";
import type { ExtensionAPI, ExtensionContext } from "@mariozechner/pi-coding-agent";

const execFileAsync = promisify(execFile);
const darkTheme = "poimandres-dark";
const lightTheme = "poimandres-light";
const pollIntervalMs = 2000;

async function isMacOsDarkMode(): Promise<boolean | undefined> {
  if (process.platform !== "darwin") return undefined;

  try {
    const { stdout } = await execFileAsync("defaults", ["read", "-g", "AppleInterfaceStyle"]);
    return stdout.trim() === "Dark";
  } catch {
    return false;
  }
}

function isTerminalDarkMode(): boolean | undefined {
  const colorFgBg = process.env.COLORFGBG;
  if (!colorFgBg) return undefined;

  const parts = colorFgBg.split(";");
  const bg = Number(parts[parts.length - 1]);
  if (!Number.isFinite(bg)) return undefined;

  // COLORFGBG convention: 0-6 are dark-ish, 7 and 8-15 are light/bright.
  return bg < 7;
}

async function preferredTheme(): Promise<string> {
  const macOsDarkMode = await isMacOsDarkMode();
  const darkMode = macOsDarkMode ?? isTerminalDarkMode() ?? true;
  return darkMode ? darkTheme : lightTheme;
}

export default function (pi: ExtensionAPI) {
  let intervalId: ReturnType<typeof setInterval> | undefined;
  let currentTheme: string | undefined;

  async function syncTheme(ctx: ExtensionContext) {
    const nextTheme = await preferredTheme();
    if (nextTheme === currentTheme) return;

    currentTheme = nextTheme;
    ctx.ui.setTheme(nextTheme);
  }

  pi.on("session_start", async (_event, ctx) => {
    await syncTheme(ctx);

    intervalId = setInterval(() => {
      void syncTheme(ctx);
    }, pollIntervalMs);
  });

  pi.on("session_shutdown", () => {
    if (intervalId) {
      clearInterval(intervalId);
      intervalId = undefined;
    }
  });
}
