require('gitsigns').setup{
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '•', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '•', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '•', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '•', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '•', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  current_line_blame_opts = {
    delay = 200,
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map('n', '<leader>B', function() gs.blame_line{full=true} end)
    map('n', '<leader>b', gs.toggle_current_line_blame)
  end
}
