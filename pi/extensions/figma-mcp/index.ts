import { spawn } from "node:child_process";
import { createServer, type Server } from "node:http";
import { mkdirSync, readFileSync, writeFileSync } from "node:fs";
import { homedir } from "node:os";
import { dirname, join } from "node:path";
import { URL } from "node:url";

import type { ExtensionAPI, ExtensionContext } from "@earendil-works/pi-coding-agent";
import { Client } from "@modelcontextprotocol/sdk/client/index.js";
import { UnauthorizedError, type OAuthClientProvider, type OAuthDiscoveryState } from "@modelcontextprotocol/sdk/client/auth.js";
import { StreamableHTTPClientTransport } from "@modelcontextprotocol/sdk/client/streamableHttp.js";
import type {
	OAuthClientInformationMixed,
	OAuthClientMetadata,
	OAuthTokens,
} from "@modelcontextprotocol/sdk/shared/auth.js";
import { Type } from "typebox";

type JsonObject = Record<string, unknown>;

type PersistedOAuthState = {
	clientInformation?: OAuthClientInformationMixed;
	tokens?: OAuthTokens;
	codeVerifier?: string;
	discoveryState?: OAuthDiscoveryState;
};

type McpTool = {
	name: string;
	description?: string;
	inputSchema: JsonObject;
	annotations?: {
		title?: string;
		readOnlyHint?: boolean;
		destructiveHint?: boolean;
		idempotentHint?: boolean;
		openWorldHint?: boolean;
	};
};

const FIGMA_MCP_URL = process.env.FIGMA_MCP_URL ?? "http://127.0.0.1:3845/mcp";
const CALLBACK_PORT = Number.parseInt(process.env.FIGMA_MCP_CALLBACK_PORT ?? "33873", 10);
const CALLBACK_URL = `http://127.0.0.1:${CALLBACK_PORT}/callback`;
const STATE_PATH = process.env.FIGMA_MCP_STATE_PATH ?? join(homedir(), ".pi", "figma-mcp-oauth.json");

const FigmaCallParams = Type.Object({
	toolName: Type.String({ description: "Exact Figma MCP tool name to call." }),
	arguments: Type.Optional(Type.Record(Type.String(), Type.Unknown(), { description: "JSON object arguments for the MCP tool." })),
});

class FileOAuthProvider implements OAuthClientProvider {
	clientMetadataUrl?: string;
	private persisted: PersistedOAuthState;
	private onRedirectUrl?: (url: URL) => void | Promise<void>;

	constructor(onRedirectUrl?: (url: URL) => void | Promise<void>) {
		this.onRedirectUrl = onRedirectUrl;
		this.persisted = this.loadState();
	}

	get redirectUrl() {
		return CALLBACK_URL;
	}

	get clientMetadata(): OAuthClientMetadata {
		return {
			client_name: "Pi Figma MCP",
			redirect_uris: [CALLBACK_URL],
			grant_types: ["authorization_code", "refresh_token"],
			response_types: ["code"],
			token_endpoint_auth_method: "client_secret_post",
		};
	}

	clientInformation() {
		return this.persisted.clientInformation;
	}

	saveClientInformation(clientInformation: OAuthClientInformationMixed) {
		this.persisted.clientInformation = clientInformation;
		this.saveState();
	}

	tokens() {
		return this.persisted.tokens;
	}

	saveTokens(tokens: OAuthTokens) {
		this.persisted.tokens = tokens;
		this.saveState();
	}

	async redirectToAuthorization(authorizationUrl: URL) {
		await this.onRedirectUrl?.(authorizationUrl);
	}

	saveCodeVerifier(codeVerifier: string) {
		this.persisted.codeVerifier = codeVerifier;
		this.saveState();
	}

	codeVerifier() {
		if (!this.persisted.codeVerifier) {
			throw new Error("No OAuth code verifier was saved");
		}
		return this.persisted.codeVerifier;
	}

	saveDiscoveryState(discoveryState: OAuthDiscoveryState) {
		this.persisted.discoveryState = discoveryState;
		this.saveState();
	}

	discoveryState() {
		return this.persisted.discoveryState;
	}

	invalidateCredentials(scope: "all" | "client" | "tokens" | "verifier" | "discovery") {
		if (scope === "all" || scope === "client") this.persisted.clientInformation = undefined;
		if (scope === "all" || scope === "tokens") this.persisted.tokens = undefined;
		if (scope === "all" || scope === "verifier") this.persisted.codeVerifier = undefined;
		if (scope === "all" || scope === "discovery") this.persisted.discoveryState = undefined;
		this.saveState();
	}

	private loadState(): PersistedOAuthState {
		try {
			return JSON.parse(readFileSync(STATE_PATH, "utf8")) as PersistedOAuthState;
		} catch {
			return {};
		}
	}

	private saveState() {
		mkdirSync(dirname(STATE_PATH), { recursive: true });
		writeFileSync(STATE_PATH, JSON.stringify(this.persisted, null, 2), { mode: 0o600 });
	}
}

function waitForOAuthCallback(): Promise<string> {
	return new Promise((resolve, reject) => {
		let server: Server | undefined;
		const timeout = setTimeout(() => {
			server?.close();
			reject(new Error("Timed out waiting for Figma OAuth callback"));
		}, 5 * 60 * 1000);

		server = createServer((req, res) => {
			const parsedUrl = new URL(req.url ?? "/", CALLBACK_URL);
			const code = parsedUrl.searchParams.get("code");
			const error = parsedUrl.searchParams.get("error");

			if (code) {
				res.writeHead(200, { "Content-Type": "text/html" });
				res.end("<h1>Figma authorization complete</h1><p>You can close this tab and return to pi.</p>");
				clearTimeout(timeout);
				resolve(code);
				setTimeout(() => server?.close(), 500);
				return;
			}

			if (error) {
				res.writeHead(400, { "Content-Type": "text/html" });
				res.end(`<h1>Figma authorization failed</h1><p>${error}</p>`);
				clearTimeout(timeout);
				reject(new Error(`Figma OAuth failed: ${error}`));
				setTimeout(() => server?.close(), 500);
				return;
			}

			res.writeHead(404);
			res.end("Not found");
		});

		server.once("error", reject);
		server.listen(CALLBACK_PORT, "127.0.0.1");
	});
}

function openBrowser(url: string) {
	const opener = process.platform === "darwin" ? "open" : process.platform === "win32" ? "cmd" : "xdg-open";
	const args = process.platform === "win32" ? ["/c", "start", "", url] : [url];
	const child = spawn(opener, args, { detached: true, stdio: "ignore" });
	child.unref();
}

function isLocalMcpUrl(url: string) {
	const parsed = new URL(url);
	return parsed.hostname === "127.0.0.1" || parsed.hostname === "localhost" || parsed.hostname === "::1";
}

function formatMcpResult(result: unknown): string {
	if (!result || typeof result !== "object") return String(result);
	const record = result as JsonObject;
	const content = record.content;
	const parts: string[] = [];

	if (Array.isArray(content)) {
		for (const item of content) {
			if (!item || typeof item !== "object") continue;
			const contentItem = item as JsonObject;
			if (contentItem.type === "text" && typeof contentItem.text === "string") {
				parts.push(contentItem.text);
			} else if (contentItem.type === "resource") {
				parts.push(JSON.stringify(contentItem.resource, null, 2));
			} else if (contentItem.type === "image") {
				parts.push(`[image: ${String(contentItem.mimeType ?? "unknown mime type")}]`);
			} else {
				parts.push(JSON.stringify(contentItem, null, 2));
			}
		}
	}

	if (record.structuredContent) {
		parts.push(`structuredContent:\n${JSON.stringify(record.structuredContent, null, 2)}`);
	}

	if (parts.length > 0) return parts.join("\n\n");
	return JSON.stringify(result, null, 2);
}

export default function figmaMcpExtension(pi: ExtensionAPI) {
	let client: Client | undefined;
	let transport: StreamableHTTPClientTransport | undefined;
	let tools: McpTool[] = [];
	let connecting: Promise<Client> | undefined;
	const registeredDynamicTools = new Set<string>();

	const connect = async (ctx?: ExtensionContext, interactive = false): Promise<Client> => {
		if (client) return client;
		if (connecting) return connecting;

		connecting = (async () => {
			const needsOAuth = !isLocalMcpUrl(FIGMA_MCP_URL);
			const authProvider = needsOAuth
				? new FileOAuthProvider((authorizationUrl) => {
						ctx?.ui.notify(`Opening Figma authorization URL: ${authorizationUrl.toString()}`, "info");
						openBrowser(authorizationUrl.toString());
					})
				: undefined;
			const nextClient = new Client({ name: "pi-figma-mcp", version: "0.1.0" }, { capabilities: {} });
			const nextTransport = new StreamableHTTPClientTransport(new URL(FIGMA_MCP_URL), { authProvider });

			try {
				await nextClient.connect(nextTransport);
			} catch (error) {
				if (!(error instanceof UnauthorizedError)) {
					const message = error instanceof Error ? error.message : String(error);
					if (FIGMA_MCP_URL.includes("mcp.figma.com") && message.includes("403")) {
						throw new Error(
							"Figma rejected this custom MCP client with HTTP 403. Figma currently gates the remote MCP server to catalog clients. Use the desktop server instead: enable Figma Desktop → Dev Mode → MCP server, then leave FIGMA_MCP_URL unset or set it to http://127.0.0.1:3845/mcp.",
						);
					}
					throw error;
				}
				if (!interactive) {
					throw new Error("Figma MCP authorization required. Run /figma-auth, then retry.");
				}

				ctx?.ui.notify("Waiting for Figma OAuth callback…", "info");
				const code = await waitForOAuthCallback();
				await nextTransport.finishAuth(code);

				const retryClient = new Client({ name: "pi-figma-mcp", version: "0.1.0" }, { capabilities: {} });
				const retryTransport = new StreamableHTTPClientTransport(new URL(FIGMA_MCP_URL), { authProvider });
				await retryClient.connect(retryTransport);
				client = retryClient;
				transport = retryTransport;
				return retryClient;
			}

			client = nextClient;
			transport = nextTransport;
			return nextClient;
		})();

		try {
			return await connecting;
		} finally {
			connecting = undefined;
		}
	};

	const registerDynamicTool = (tool: McpTool) => {
		const piToolName = `figma_mcp_${tool.name.replace(/[^a-zA-Z0-9_-]/g, "_")}`;
		if (registeredDynamicTools.has(piToolName)) return;
		registeredDynamicTools.add(piToolName);

		pi.registerTool({
			name: piToolName,
			label: tool.annotations?.title ?? `Figma: ${tool.name}`,
			description: tool.description ?? `Call the Figma MCP tool '${tool.name}'.`,
			parameters: tool.inputSchema as never,
			async execute(_toolCallId, params, _signal, _onUpdate, ctx) {
				const activeClient = await connect(ctx);
				const isReadOnly = tool.annotations?.readOnlyHint === true;
				if (!isReadOnly) {
					const ok = await ctx.ui.confirm(
						"Figma write confirmation",
						`Call Figma MCP tool '${tool.name}'? This may create or update Figma content.`,
					);
					if (!ok) {
						return {
							content: [{ type: "text", text: "Cancelled Figma MCP tool call" }],
							details: { cancelled: true, toolName: tool.name },
						};
					}
				}

				const result = await activeClient.callTool({ name: tool.name, arguments: params as JsonObject });
				return {
					content: [{ type: "text", text: formatMcpResult(result) }],
					details: { toolName: tool.name, result },
				};
			},
		});
	};

	const refreshTools = async (ctx?: ExtensionContext) => {
		const activeClient = await connect(ctx);
		const result = await activeClient.listTools();
		tools = result.tools as McpTool[];
		for (const tool of tools) {
			registerDynamicTool(tool);
		}
		return tools;
	};

	const findTool = async (toolName: string, ctx?: ExtensionContext) => {
		if (tools.length === 0) await refreshTools(ctx);
		return tools.find((tool) => tool.name === toolName);
	};

	pi.registerCommand("figma-auth", {
		description: "Connect pi to the Figma MCP server and authorize if needed",
		handler: async (_args, ctx) => {
			await connect(ctx, true);
			await refreshTools(ctx);
			ctx.ui.notify(`Connected to Figma MCP. Loaded ${tools.length} tools.`, "success");
		},
	});

	pi.registerCommand("figma-tools", {
		description: "List tools exposed by the Figma MCP server",
		handler: async (_args, ctx) => {
			const availableTools = await refreshTools(ctx);
			const lines = availableTools.map((tool) => {
				const mode = tool.annotations?.readOnlyHint ? "read" : "write?";
				return `${tool.name} (${mode})${tool.description ? ` — ${tool.description}` : ""}`;
			});
			ctx.ui.notify(lines.join("\n") || "No Figma MCP tools found", "info");
		},
	});

	pi.registerCommand("figma-disconnect", {
		description: "Close the current Figma MCP connection",
		handler: async (_args, ctx) => {
			await transport?.close();
			transport = undefined;
			client = undefined;
			tools = [];
			ctx.ui.notify("Disconnected from Figma MCP", "info");
		},
	});

	pi.registerTool({
		name: "figma_mcp_list_tools",
		label: "Figma MCP tools",
		description: "List tools currently exposed by the remote Figma MCP server.",
		parameters: Type.Object({}),
		async execute(_toolCallId, _params, _signal, _onUpdate, ctx) {
			const availableTools = await refreshTools(ctx);
			return {
				content: [{ type: "text", text: JSON.stringify(availableTools, null, 2) }],
				details: { count: availableTools.length, tools: availableTools },
			};
		},
	});

	pi.registerTool({
		name: "figma_mcp_call_tool",
		label: "Figma MCP call",
		description:
			"Call a tool on the remote Figma MCP server. Use figma_mcp_list_tools first to inspect exact tool names and schemas.",
		parameters: FigmaCallParams,
		async execute(_toolCallId, params, _signal, _onUpdate, ctx) {
			const activeClient = await connect(ctx);
			const tool = await findTool(params.toolName, ctx);
			if (!tool) {
				return {
					content: [{ type: "text", text: `Figma MCP tool not found: ${params.toolName}` }],
					details: { error: "tool_not_found", toolName: params.toolName },
				};
			}

			const isReadOnly = tool.annotations?.readOnlyHint === true;
			if (!isReadOnly) {
				const ok = await ctx.ui.confirm(
					"Figma write confirmation",
					`Call Figma MCP tool '${params.toolName}'? This may create or update Figma content.`,
				);
				if (!ok) {
					return {
						content: [{ type: "text", text: "Cancelled Figma MCP tool call" }],
						details: { cancelled: true, toolName: params.toolName },
					};
				}
			}

			const result = await activeClient.callTool({ name: params.toolName, arguments: params.arguments ?? {} });
			return {
				content: [{ type: "text", text: formatMcpResult(result) }],
				details: { toolName: params.toolName, result },
			};
		},
	});
}
