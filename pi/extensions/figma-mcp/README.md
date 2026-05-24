# Figma MCP pi extension

Bridges pi to Figma's MCP server. By default it connects to the Figma Desktop MCP server at `http://127.0.0.1:3845/mcp` because Figma currently gates the remote server to catalog clients.

## Usage

1. In Figma Desktop, open the target file, switch to Dev Mode, and enable the MCP server.
2. Restart pi or run `/reload`.
3. Run `/figma-auth` to connect.
4. Run `/figma-tools` or ask the agent to call `figma_mcp_list_tools`.
5. Use `figma_mcp_call_tool` to call a specific Figma MCP tool.

Write-capable tools prompt for confirmation before execution unless the MCP tool advertises `readOnlyHint`.

## Configuration

Environment variables:

- `FIGMA_MCP_URL` — defaults to `http://127.0.0.1:3845/mcp`; set to `https://mcp.figma.com/mcp` to try the remote server
- `FIGMA_MCP_CALLBACK_PORT` — defaults to `33873`
- `FIGMA_MCP_STATE_PATH` — defaults to `~/.pi/figma-mcp-oauth.json`

Figma docs note that only clients in the Figma MCP Catalog can connect to the remote server. If Figma rejects pi with HTTP 403, use the Desktop MCP server or request catalog/waitlist access for pi.
