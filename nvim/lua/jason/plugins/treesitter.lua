require'nvim-treesitter.configs'.setup {
  ensure_installed = { "html", "css", "markdown", "javascript", "typescript", "json", "lua", "prisma", "ruby", "rust", "tsx", "vim", "yaml" },
  highlight = {
    enable = true
  },
  indent = {
    enable = true
  },
  playground = {
    enable = true
  },
  context_commentstring = {
    enable = true
  },
  autotag = {
    enable = true,
  },
  auto_install = true,
}
