return {
  "L3MON4D3/LuaSnip",
  config = function()
    require("luasnip").filetype_extend("javascriptreact", { "html" })
    require("luasnip").filetype_extend("typescriptreact", { "html" })
    require("luasnip.loaders.from_vscode").lazy_load()
  end,
}
