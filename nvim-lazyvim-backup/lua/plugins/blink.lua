return {
  "saghen/blink.cmp",
  dependencies = {
    "fang2hou/blink-copilot",
  },
  opts = {
    sources = {
      default = { "lsp", "snippets", "copilot", "path", "buffer" },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = -10,
          async = true,
        },
      },
    },
  },
}
