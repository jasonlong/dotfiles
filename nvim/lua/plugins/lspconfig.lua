return {
  "neovim/nvim-lspconfig",

  opts = {
    inlay_hints = { enabled = false },
    setup = {
      eslint = function()
        Snacks.util.lsp.on({ name = "eslint" }, function(_, client)
          client.server_capabilities.documentFormattingProvider = true
        end)
        Snacks.util.lsp.on({ name = "tsserver" }, function(_, client)
          client.server_capabilities.documentFormattingProvider = false
        end)
      end,
    },
    servers = {
      -- eslint = {},
      tailwindcss = {
        settings = {
          tailwindCSS = {
            lint = {
              invalidApply = false,
            },
          },
        },
      },
      emmet_language_server = {
        filetypes = { "html", "typescriptreact", "javascriptreact" },
        init_options = {
          syntaxProfiles = {
            html = {
              attr_quotes = "single",
            },
            typescriptreact = {
              attr_quotes = "single",
            },
          },
        },
      },
      cssls = {
        settings = {
          css = {
            validate = true,
            lint = {
              unknownAtRules = "ignore",
            },
          },
          scss = {
            validate = true,
            lint = {
              unknownAtRules = "ignore",
            },
          },
        },
      },
    },
  },
}
