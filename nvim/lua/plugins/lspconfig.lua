return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    servers = {
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
