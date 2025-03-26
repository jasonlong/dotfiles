return {
  "neovim/nvim-lspconfig",

  opts = {
    inlay_hints = { enabled = false },
    setup = {
      eslint = function()
        require("lazyvim.util").lsp.on_attach(function(client)
          if client.name == "eslint" then
            client.server_capabilities.documentFormattingProvider = true
          elseif client.name == "tsserver" then
            client.server_capabilities.documentFormattingProvider = false
          end
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
