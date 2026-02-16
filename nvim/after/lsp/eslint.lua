-- ESLint language server configuration
-- Auto-fix ESLint errors on save

return {
	settings = {
		run = "onSave",
	},
	on_attach = function(client, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			callback = function()
				local params = vim.lsp.util.make_range_params()
				params.context = { only = { "source.fixAll.eslint" }, diagnostics = {} }
				local result = client:request_sync("textDocument/codeAction", params, 3000, bufnr)
				if result and result.result and result.result[1] then
					vim.lsp.util.apply_workspace_edit(result.result[1].edit, client.offset_encoding)
				end
			end,
		})
	end,
}
