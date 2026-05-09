#!/usr/bin/env node

import { createRequire } from "node:module";
import { mkdirSync } from "node:fs";
import { join } from "node:path";
import { tmpdir } from "node:os";
import { spawn } from "node:child_process";

const require = createRequire(`${process.env.HOME}/.agents/skills/browser-tools/package.json`);
const puppeteer = require("puppeteer-core");

const BASE_URL = "http://app.pscaledev.com:3001";
const BROWSER_START = `${process.env.HOME}/.agents/skills/browser-tools/browser-start.js`;
const DEFAULT_WIDTHS = [375, 768, 1024, 1280, 1440];

const args = process.argv.slice(2);
const routeArg = args.find((arg) => !arg.startsWith("--")) ?? "/";
const widthsArg = args.find((arg) => arg.startsWith("--widths="));
const shouldScreenshot = args.includes("--screenshots");
const widths = widthsArg
	? widthsArg.replace("--widths=", "").split(",").map((value) => Number.parseInt(value, 10)).filter(Number.isFinite)
	: DEFAULT_WIDTHS;
const url = routeArg.startsWith("http://") || routeArg.startsWith("https://") ? routeArg : `${BASE_URL}${routeArg.startsWith("/") ? routeArg : `/${routeArg}`}`;

function delay(ms) {
	return new Promise((resolve) => setTimeout(resolve, ms));
}

async function connect() {
	return puppeteer.connect({ browserURL: "http://localhost:9222", defaultViewport: null });
}

async function ensureBrowser() {
	try {
		const browser = await connect();
		await browser.disconnect();
		return;
	} catch {}

	await new Promise((resolve, reject) => {
		const child = spawn(BROWSER_START, [], { stdio: "inherit" });
		child.on("error", reject);
		child.on("exit", (code) => {
			if (code === 0) resolve();
			else reject(new Error(`browser-start.js exited with ${code}`));
		});
	});
}

async function getActivePage(browser) {
	const pages = await browser.pages();
	const appPage = pages.find((page) => page.url().startsWith(BASE_URL));
	if (appPage) return appPage;

	const webPage = pages.find((page) => /^https?:\/\//.test(page.url()));
	if (webPage) return webPage;

	return browser.newPage();
}

async function clickDevSignInIfNeeded(page) {
	const isAuthPage = page.url().includes("auth.pscaledev.com") || await page.evaluate(() => /\bSign in\b/.test(document.body?.innerText ?? ""));
	if (!isAuthPage) return false;

	const clicked = await page.evaluate(() => {
		const buttons = Array.from(document.querySelectorAll("button, input[type='submit']"));
		const submit = buttons.find((element) => /sign in|submit/i.test((element.textContent || element.value || "").trim()));
		if (!(submit instanceof HTMLElement)) return false;
		submit.click();
		return true;
	});

	if (!clicked) return false;

	await page.waitForNavigation({ waitUntil: "domcontentloaded", timeout: 10000 }).catch(() => undefined);
	await delay(1000);
	return true;
}

async function openRoute(page) {
	await page.goto(url, { waitUntil: "domcontentloaded", timeout: 20000 });
	await delay(500);
	const clickedSignIn = await clickDevSignInIfNeeded(page);
	if (clickedSignIn) {
		await page.goto(url, { waitUntil: "domcontentloaded", timeout: 20000 });
		await delay(500);
	}
	return clickedSignIn;
}

function sanitizeFilename(value) {
	return value.replace(/[^a-z0-9]+/gi, "-").replace(/^-|-$/g, "").toLowerCase() || "route";
}

await ensureBrowser();
const browser = await connect();
const page = await getActivePage(browser);
const clickedSignIn = await openRoute(page);
const screenshotDir = join(tmpdir(), "app-bb-breakpoints");
mkdirSync(screenshotDir, { recursive: true });

const results = [];

for (const width of widths) {
	await page.setViewport({ width, height: 900, deviceScaleFactor: 1 });
	await page.goto(url, { waitUntil: "domcontentloaded", timeout: 20000 }).catch(() => undefined);
	await delay(900);

	const screenshot = shouldScreenshot ? join(screenshotDir, `${sanitizeFilename(routeArg)}-${width}.png`) : undefined;
	let screenshotError;
	if (screenshot) {
		try {
			await Promise.race([
				page.screenshot({ path: screenshot, fullPage: false }),
				new Promise((_, reject) => setTimeout(() => reject(new Error("screenshot timed out")), 5000)),
			]);
		} catch (error) {
			screenshotError = error instanceof Error ? error.message : String(error);
		}
	}

	const data = await page.evaluate((requestedWidth, screenshotPath, screenshotErrorMessage) => {
		const isVisible = (element) => Boolean(element.offsetWidth || element.offsetHeight || element.getClientRects().length);
		const rectFor = (selector) => {
			const element = document.querySelector(selector);
			if (!element) return undefined;
			const rect = element.getBoundingClientRect();
			return { x: Math.round(rect.x), y: Math.round(rect.y), width: Math.round(rect.width), height: Math.round(rect.height) };
		};
		const visibleControls = Array.from(document.querySelectorAll("a, button"))
			.filter(isVisible)
			.map((element) => ({
				text: (element.textContent || "").trim().replace(/\s+/g, " "),
				tag: element.tagName.toLowerCase(),
				x: Math.round(element.getBoundingClientRect().x),
				y: Math.round(element.getBoundingClientRect().y),
			}))
			.filter((item) => item.text)
			.slice(0, 40);

		return {
			requestedWidth,
			actualWidth: window.innerWidth,
			actualHeight: window.innerHeight,
			url: location.href,
			title: document.title,
			heading: document.querySelector("h1")?.textContent?.trim(),
			hasHorizontalOverflow: document.documentElement.scrollWidth > window.innerWidth,
			documentScrollWidth: document.documentElement.scrollWidth,
			bodyScrollWidth: document.body.scrollWidth,
			mainRect: rectFor("main"),
			tableRects: Array.from(document.querySelectorAll("table")).map((table) => {
				const rect = table.getBoundingClientRect();
				return {
					visible: isVisible(table),
					x: Math.round(rect.x),
					width: Math.round(rect.width),
					scrollWidth: table.scrollWidth,
					headers: Array.from(table.querySelectorAll("th")).map((th) => th.textContent?.trim()).filter(Boolean),
				};
			}),
			visibleControls,
			visibleText: (document.body.innerText || "").replace(/\n+/g, " | ").slice(0, 1200),
			screenshot: screenshotErrorMessage ? undefined : screenshotPath,
			screenshotError: screenshotErrorMessage,
		};
	}, width, screenshot, screenshotError);

	results.push(data);
}

console.log(JSON.stringify({ requestedUrl: url, clickedSignIn, results }, null, 2));
await browser.disconnect();
