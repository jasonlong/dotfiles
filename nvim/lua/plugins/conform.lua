return {
  "stevearc/conform.nvim",
  event = { "BufReadPre" }, -- replaces LazyVim's default lazy load timing
  opts = {
    formatters_by_ft = {
      javascript = { "prettierd", "eslint_d" },
      typescript = { "prettierd", "eslint_d" },
      javascriptreact = { "prettierd", "eslint_d" },
      typescriptreact = { "prettierd", "eslint_d" },
    },
    -- format_on_save = {
    --   -- Recommended: increase timeout if first save is slow and you aren't pre-starting
    --   timeout_ms = 500, -- Default is 500, maybe increase? But pre-starting is better.
    --   lsp_fallback = true, -- Or false, depending on your preference
    -- },
    -- formatters = {
    --   eslint_d = {
    --     command = "eslint_d",
    --     args = {
    --       "--stdin",
    --       "--stdin-filename",
    --       "$FILENAME",
    --       "--fix-to-stdout",
    --     },
    --     stdin = true,
    --     condition = function(ctx)
    --       local found = vim.fs.find({
    --         ".eslintrc",
    --         ".eslintrc.js",
    --         ".eslintrc.cjs",
    --         ".eslintrc.json",
    --         ".eslintrc.yaml",
    --         ".eslintrc.yml",
    --         "eslint.config.js",
    --         "eslint.config.mjs",
    --       }, { upward = true, path = ctx.dirname })
    --       return #found > 0
    --     end,
    --   },
    --   prettierd = {
    --     command = "prettierd",
    --     args = { "$FILENAME" },
    --     stdin = true,
    --   },
    -- },
  },
}
