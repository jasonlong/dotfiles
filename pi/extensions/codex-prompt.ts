/**
 * Codex Prompt
 *
 * Restyles pi's editor to look like Codex's bottom composer:
 *
 *   › Implement {feature}
 *
 *     gpt-5.5 · ~/repo
 *
 * Commands:
 *   /codex-prompt          Show current state
 *   /codex-prompt on       Enable the prompt
 *   /codex-prompt off      Restore pi's default prompt/footer
 *   /codex-prompt toggle   Toggle the prompt
 */

import type { ExtensionAPI, ExtensionContext } from "@mariozechner/pi-coding-agent";
import { Editor, truncateToWidth, visibleWidth } from "@mariozechner/pi-tui";
import { ModalEditor } from "/Users/jason/.local/share/nvm/v22.12.0/lib/node_modules/pi-vim/index.ts";

const EXTENSION_ID = "codex-prompt";
const PROMPT_PREFIX = "› ";
const CONTINUATION_PREFIX = "  ";
const PAD = "\u00A0";
const CODEX_BG = "\x1b[48;2;49;53;62m";
const RESET_BG = "\x1b[49m";

type PromptStatus = {
	left: string;
	right: string;
};

type StatusProvider = () => PromptStatus;
type CodexPromptStyles = {
	promptBg: (text: string) => string;
	glyph: (text: string) => string;
	status: (text: string) => string;
	insertMode: (text: string) => string;
	normalMode: (text: string) => string;
};

function stripAnsi(text: string): string {
	return text.replace(/\x1b\[[0-?]*[ -/]*[@-~]/g, "");
}

function isEditorRule(line: string): boolean {
	const plain = stripAnsi(line).trim();
	return plain.length > 0 && /^[─↑↓ 0-9more]+$/.test(plain);
}

class CodexPromptEditor extends ModalEditor {
	constructor(
		tui: any,
		theme: any,
		keybindings: any,
		private getStatus: StatusProvider,
		private styles: CodexPromptStyles,
	) {
		// Keep pi-vim editing behavior and replace only the rendered chrome.
		super(tui, theme, keybindings, null);
	}

	render(width: number): string[] {
		if (width < 4) return super.render(width);

		const contentWidth = Math.max(1, width - visibleWidth(PROMPT_PREFIX));
		const editorLines = Editor.prototype.render.call(this, contentWidth) as string[];
		const content = this.contentLines(editorLines);
		const inputLines = content.map((line, index) => this.renderInputLine(line, width, index === 0));
		const paddingLine = this.renderPromptPaddingLine(width);

		return [
			paddingLine,
			...inputLines,
			paddingLine,
			this.renderStatusLine(width),
		];
	}

	private contentLines(editorLines: string[]): string[] {
		let content = editorLines;
		if (isEditorRule(content[0] ?? "")) content = content.slice(1);

		const bottomRuleIndex = content.findIndex((line) => isEditorRule(line));
		if (bottomRuleIndex >= 0) {
			content = [...content.slice(0, bottomRuleIndex), ...content.slice(bottomRuleIndex + 1)];
		}

		return content.length === 0 ? [""] : content;
	}

	private renderInputLine(line: string, width: number, isFirst: boolean): string {
		const prefix = isFirst ? `${this.styles.glyph("›")} ` : CONTINUATION_PREFIX;
		const prefixWidth = isFirst ? visibleWidth(PROMPT_PREFIX) : visibleWidth(CONTINUATION_PREFIX);
		const lineWidth = Math.max(1, width - prefixWidth);
		const safeLine = truncateToWidth(line, lineWidth, "");
		const padding = PAD.repeat(Math.max(0, width - prefixWidth - visibleWidth(safeLine)));
		return this.styles.promptBg(`${prefix}${safeLine}${padding}`);
	}

	private renderPromptPaddingLine(width: number): string {
		return this.styles.promptBg(PAD.repeat(width));
	}

	private renderStatusLine(width: number): string {
		const status = this.getStatus();
		const left = `${this.styles.status(`  ${status.left} · `)}${this.modeText()}`;
		if (!status.right) return truncateToWidth(left, width, "");

		const right = this.styles.status(status.right);
		const gapWidth = width - visibleWidth(left) - visibleWidth(right);
		if (gapWidth < 1) return truncateToWidth(left, width, "");

		return `${left}${" ".repeat(gapWidth)}${right}`;
	}

	private modeText(): string {
		const mode = this.getMode();
		const label = mode.toUpperCase();
		return mode === "insert" ? this.styles.insertMode(label) : this.styles.normalMode(label);
	}
}

function compactPath(path: string): string {
	const home = process.env.HOME;
	return home && path.startsWith(home) ? `~${path.slice(home.length)}` : path;
}

function makeStyles(ctx: ExtensionContext): CodexPromptStyles {
	const theme = ctx.ui.theme;
	return {
		// Re-apply the background after the editor cursor emits a full SGR reset.
		promptBg: (text: string) => `${CODEX_BG}${text.replace(/\x1b\[0m/g, `\x1b[0m${CODEX_BG}`)}${RESET_BG}`,
		glyph: (text: string) => theme.fg("accent", text),
		status: (text: string) => theme.fg("dim", text),
		insertMode: (text: string) => theme.fg("accent", text),
		normalMode: (text: string) => theme.fg("dim", text),
	};
}

function formatCount(value: number): string {
	if (value >= 1_000_000) return `${(value / 1_000_000).toFixed(1)}M`;
	if (value >= 1_000) return `${(value / 1_000).toFixed(0)}k`;
	return `${value}`;
}

function currentEffort(ctx: ExtensionContext): string {
	let effort = "off";

	for (const entry of ctx.sessionManager.getBranch()) {
		if (entry.type === "thinking_level_change") effort = entry.thinkingLevel;
	}

	return effort;
}

function usageStats(ctx: ExtensionContext): string {
	const parts = [`effort ${currentEffort(ctx)}`];
	const contextUsage = ctx.getContextUsage();
	if (contextUsage && contextUsage.percent !== null && contextUsage.tokens !== null) {
		parts.push(`${contextUsage.percent.toFixed(1)}%`, formatCount(contextUsage.contextWindow));
	}

	return parts.join(" · ");
}

function statusFor(ctx: ExtensionContext): StatusProvider {
	return () => ({
		left: compactPath(ctx.cwd),
		right: `${ctx.model?.id ?? "no model"} · ${usageStats(ctx)}`,
	});
}

export default function (pi: ExtensionAPI) {
	let enabled = true;
	let pendingApplies: ReturnType<typeof setTimeout>[] = [];

	const hideFooter = (ctx: ExtensionContext) => {
		ctx.ui.setFooter(() => ({
			render: () => [],
			invalidate: () => {},
		}));
	};

	const apply = (ctx: ExtensionContext) => {
		if (enabled) {
			const styles = makeStyles(ctx);
			ctx.ui.setEditorComponent((tui, theme, keybindings) =>
				new CodexPromptEditor(tui, theme, keybindings, statusFor(ctx), styles),
			);
			hideFooter(ctx);
			ctx.ui.setStatus(EXTENSION_ID, undefined);
		} else {
			ctx.ui.setEditorComponent(undefined);
			ctx.ui.setFooter(undefined);
			ctx.ui.setStatus(EXTENSION_ID, undefined);
		}
	};

	const cancelPendingApplies = () => {
		for (const pendingApply of pendingApplies) clearTimeout(pendingApply);
		pendingApplies = [];
	};

	const applyAfterOtherEditorExtensions = (ctx: ExtensionContext) => {
		// Package extensions such as pi-vim also call setEditorComponent() during
		// session_start. Apply a few times across startup ticks so this visual skin
		// wins regardless of package/local extension ordering.
		cancelPendingApplies();
		for (const delayMs of [0, 25, 100]) {
			pendingApplies.push(setTimeout(() => apply(ctx), delayMs));
		}
	};

	pi.on("session_start", async (_event, ctx) => {
		applyAfterOtherEditorExtensions(ctx);
	});

	pi.on("model_select", async (_event, ctx) => {
		if (enabled) applyAfterOtherEditorExtensions(ctx);
	});

	pi.on("session_shutdown", async (_event, ctx) => {
		cancelPendingApplies();
		ctx.ui.setEditorComponent(undefined);
		ctx.ui.setFooter(undefined);
		ctx.ui.setStatus(EXTENSION_ID, undefined);
	});

	pi.registerCommand("codex-prompt", {
		description: "Toggle the Codex-like prompt editor style.",
		handler: async (args, ctx) => {
			const action = args.trim().toLowerCase();

			if (!action) {
				ctx.ui.notify(`Codex prompt is ${enabled ? "enabled" : "disabled"}.`, "info");
				return;
			}

			switch (action) {
			case "on":
				enabled = true;
				break;
			case "off":
				enabled = false;
				break;
			case "toggle":
				enabled = !enabled;
				break;
			default:
				ctx.ui.notify("Usage: /codex-prompt [on|off|toggle]", "error");
				return;
			}

			apply(ctx);
			ctx.ui.notify(`Codex prompt ${enabled ? "enabled" : "disabled"}.`, "info");
		},
	});
}
