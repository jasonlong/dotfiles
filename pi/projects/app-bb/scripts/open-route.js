#!/usr/bin/env node

import { createRequire } from "node:module";
import { spawn } from "node:child_process";

const require = createRequire(`${process.env.HOME}/.agents/skills/browser-tools/package.json`);
const puppeteer = require("puppeteer-core");

const BASE_URL = "http://app.pscaledev.com:3001";
const BROWSER_START = `${process.env.HOME}/.agents/skills/browser-tools/browser-start.js`;

const input = process.argv[2] ?? "/";
const routeOrUrl = input.startsWith("http://") || input.startsWith("https://") ? input : `${BASE_URL}${input.startsWith("/") ? input : `/${input}`}`;

function delay(ms) {
	return new Promise((resolve) => setTimeout(resolve, ms));
}

async function connect() {
	return puppeteer.connect({
		browserURL: "http://localhost:9222",
		defaultViewport: null,
	});
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

async function pageSnapshot(page) {
	return page.evaluate(() => ({
		url: location.href,
		title: document.title,
		text: document.body?.innerText?.slice(0, 1000) ?? "",
	}));
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

await ensureBrowser();

let browser = await connect();
let page = await getActivePage(browser);

await page.goto(routeOrUrl, { waitUntil: "domcontentloaded" });
await delay(500);

const clickedSignIn = await clickDevSignInIfNeeded(page);
if (clickedSignIn) {
	// After auth, explicitly revisit the desired route. This avoids relying on return_to
	// redirects and makes the helper resilient to navigation timing.
	await page.goto(routeOrUrl, { waitUntil: "domcontentloaded" }).catch(async () => {
		await browser.disconnect().catch(() => undefined);
		await ensureBrowser();
		browser = await connect();
		page = await getActivePage(browser);
		await page.goto(routeOrUrl, { waitUntil: "domcontentloaded" });
	});
	await delay(500);
}

const snapshot = await pageSnapshot(page);
console.log(JSON.stringify({ requestedUrl: routeOrUrl, clickedSignIn, ...snapshot }, null, 2));

await browser.disconnect();
