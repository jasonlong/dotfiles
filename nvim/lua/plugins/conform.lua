return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      vue = { "eslint_d" },
    },
    formatters = {
      eslint_d = {
        command = "eslint_d",
        args = {
          "--stdin",
          "--stdin-filename",
          "$FILENAME",
          "--fix-to-stdout",
        },
        stdin = true,
        require_cwd = true,
      },
    },
  },
}
