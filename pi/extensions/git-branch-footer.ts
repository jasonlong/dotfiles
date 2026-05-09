import type { AssistantMessage } from "@mariozechner/pi-ai";
import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";
import { truncateToWidth, visibleWidth } from "@mariozechner/pi-tui";

function formatTokens(count: number): string {
	if (count < 1000) return count.toString();
	if (count < 10000) return `${(count / 1000).toFixed(1)}k`;
	if (count < 1000000) return `${Math.round(count / 1000)}k`;
	if (count < 10000000) return `${(count / 1000000).toFixed(1)}M`;
	return `${Math.round(count / 1000000)}M`;
}

function displayCwd(cwd: string): string {
	const home = process.env.HOME || process.env.USERPROFILE;
	if (home && cwd.startsWith(home)) return `~${cwd.slice(home.length)}`;
	return cwd;
}

function sanitizeStatusText(text: string): string {
	return text.replace(/[\r\n\t]/g, " ").replace(/ +/g, " ").trim();
}

export default function (pi: ExtensionAPI) {
	let thinkingLevel = "off";

	pi.on("thinking_level_select", (event) => {
		thinkingLevel = event.level;
	});

	pi.on("session_start", (_event, ctx) => {
		ctx.ui.setFooter((tui, theme, footerData) => ({
			dispose: footerData.onBranchChange(() => tui.requestRender()),
			invalidate() {},
			render(width: number): string[] {
				let input = 0;
				let output = 0;
				let cacheRead = 0;
				let cacheWrite = 0;

				for (const entry of ctx.sessionManager.getEntries()) {
					if (entry.type === "message" && entry.message.role === "assistant") {
						const message = entry.message as AssistantMessage;
						input += message.usage.input;
						output += message.usage.output;
						cacheRead += message.usage.cacheRead;
						cacheWrite += message.usage.cacheWrite;
					}
				}

				let cwd = displayCwd(ctx.cwd);
				const branch = footerData.getGitBranch();
				if (branch) cwd = `${cwd} (${branch})`;

				const sessionName = pi.getSessionName();
				if (sessionName) cwd = `${cwd} • ${sessionName}`;

				const usage = ctx.getContextUsage();
				const contextWindow = usage?.contextWindow ?? ctx.model?.contextWindow ?? 0;
				const contextPercentValue = usage?.percent ?? 0;
				const contextPercent = usage?.percent == null ? "?" : usage.percent.toFixed(1);
				const contextDisplay = `${contextPercent}%/${formatTokens(contextWindow)}`;
				const coloredContext = contextPercentValue > 90
					? theme.fg("error", contextDisplay)
					: contextPercentValue > 70
						? theme.fg("warning", contextDisplay)
						: contextDisplay;

				const statsParts = [];
				if (input) statsParts.push(`↑${formatTokens(input)}`);
				if (output) statsParts.push(`↓${formatTokens(output)}`);
				if (cacheRead) statsParts.push(`R${formatTokens(cacheRead)}`);
				if (cacheWrite) statsParts.push(`W${formatTokens(cacheWrite)}`);
				statsParts.push(coloredContext);

				let left = statsParts.join(" ");
				if (visibleWidth(left) > width) left = truncateToWidth(left, width, "...");

				const model = ctx.model;
				const modelText = model ? `${model.id} • effort ${thinkingLevel}` : "no-model";
				let right = model && footerData.getAvailableProviderCount() > 1 ? `(${model.provider}) ${modelText}` : modelText;

				const minPadding = 2;
				if (visibleWidth(left) + minPadding + visibleWidth(right) > width) {
					right = modelText;
				}

				const leftWidth = visibleWidth(left);
				const availableForRight = width - leftWidth - minPadding;
				let statsLine = left;
				if (availableForRight > 0) {
					const fittedRight = leftWidth + minPadding + visibleWidth(right) <= width ? right : truncateToWidth(right, availableForRight, "");
					const padding = " ".repeat(Math.max(minPadding, width - leftWidth - visibleWidth(fittedRight)));
					statsLine = left + padding + fittedRight;
				}

				const lines = [
					truncateToWidth(theme.fg("dim", cwd), width, theme.fg("dim", "...")),
					theme.fg("dim", statsLine),
				];

				const statuses = Array.from(footerData.getExtensionStatuses().entries())
					.sort(([a], [b]) => a.localeCompare(b))
					.map(([, text]) => sanitizeStatusText(text));
				if (statuses.length > 0) {
					lines.push(truncateToWidth(statuses.join(" "), width, theme.fg("dim", "...")));
				}

				return lines;
			},
		}));
	});
}
