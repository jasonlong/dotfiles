# MiniMax Neovim Keybinding Cheat Sheet

**Leader Key:** `<Space>`

## Buffer Operations (`<Leader>b`)

| Key | Description |
|-----|-------------|
| `<Leader>ba` | Alternate buffer (switch to last) |
| `<Leader>bd` | Delete buffer |
| `<Leader>bD` | Delete buffer (force) |
| `<Leader>bs` | Create scratch buffer |
| `<Leader>bw` | Wipeout buffer |
| `<Leader>bW` | Wipeout buffer (force) |

## Explore/Edit (`<Leader>e`)

| Key | Description |
|-----|-------------|
| `<Leader>ed` | Open file explorer at cwd |
| `<Leader>ef` | Open file explorer at current file |
| `<Leader>ei` | Edit init.lua |
| `<Leader>ek` | Edit keymaps (20_keymaps.lua) |
| `<Leader>em` | Edit MINI config (30_mini.lua) |
| `<Leader>en` | Show notification history |
| `<Leader>eo` | Edit options (10_options.lua) |
| `<Leader>ep` | Edit plugins (40_plugins.lua) |
| `<Leader>eq` | Toggle quickfix window |

## Find/Pick (`<Leader>f`)

| Key | Description |
|-----|-------------|
| `<Leader>ff` | Find files |
| `<Leader>fg` | Grep live (search in files) |
| `<Leader>fG` | Grep word under cursor |
| `<Leader>fb` | Pick buffers |
| `<Leader>fh` | Help tags |
| `<Leader>fr` | Resume last picker |
| `<Leader>fl` | Lines (all buffers) |
| `<Leader>fL` | Lines (current buffer) |
| `<Leader>fd` | Diagnostics (workspace) |
| `<Leader>fD` | Diagnostics (buffer) |
| `<Leader>fc` | Git commits (all) |
| `<Leader>fC` | Git commits (buffer) |
| `<Leader>fR` | LSP references |
| `<Leader>fs` | LSP symbols (workspace) |
| `<Leader>fS` | LSP symbols (document) |
| `<Leader>fv` | Visit paths (all) |
| `<Leader>fV` | Visit paths (cwd) |
| `<Leader>f/` | Search "/" history |
| `<Leader>f:` | Search ":" history |

## Git Operations (`<Leader>g`)

| Key | Description |
|-----|-------------|
| `<Leader>gs` | Show git info at cursor |
| `<Leader>gd` | Git diff |
| `<Leader>gD` | Git diff (buffer) |
| `<Leader>ga` | Show staged diff |
| `<Leader>gA` | Show staged diff (buffer) |
| `<Leader>gc` | Git commit |
| `<Leader>gC` | Git commit --amend |
| `<Leader>gl` | Git log |
| `<Leader>gL` | Git log (buffer) |
| `<Leader>go` | Toggle diff overlay |

## LSP (`<Leader>l`)

| Key | Description |
|-----|-------------|
| `<Leader>la` | Code actions |
| `<Leader>ld` | Diagnostic popup |
| `<Leader>lf` | Format buffer/selection |
| `<Leader>lh` | Hover documentation |
| `<Leader>li` | Go to implementation |
| `<Leader>lr` | Rename symbol |
| `<Leader>lR` | Show references |
| `<Leader>ls` | Go to source definition |
| `<Leader>lt` | Go to type definition |

## Session (`<Leader>s`)

| Key | Description |
|-----|-------------|
| `<Leader>sn` | New session |
| `<Leader>sr` | Read/restore session |
| `<Leader>sw` | Write/save session |
| `<Leader>sd` | Delete session |

## Visits/Labels (`<Leader>v`)

| Key | Description |
|-----|-------------|
| `<Leader>vv` | Add "core" label to file |
| `<Leader>vV` | Remove "core" label |
| `<Leader>vc` | Pick "core" files (all) |
| `<Leader>vC` | Pick "core" files (cwd) |
| `<Leader>vl` | Add custom label |
| `<Leader>vL` | Remove custom label |

## Other (`<Leader>o/m/t`)

| Key | Description |
|-----|-------------|
| `<Leader>oz` | Zoom toggle window |
| `<Leader>or` | Resize window to default |
| `<Leader>ot` | Trim trailing whitespace |
| `<Leader>mt` | Toggle map |
| `<Leader>mf` | Focus map |
| `<Leader>ms` | Toggle map side |
| `<Leader>tt` | Terminal (vertical) |
| `<Leader>tT` | Terminal (horizontal) |

## mini.basics

| Key | Description |
|-----|-------------|
| `<C-s>` (Insert) | Save and go to Normal |
| `go` / `gO` | Insert empty line below/above |
| `gy` / `gp` | Copy/paste system clipboard |
| `<C-h/j/k/l>` | Navigate windows |
| `\h` | Toggle search highlighting |

## Navigation (`[` / `]`)

| Key | Description |
|-----|-------------|
| `[b` / `]b` | Previous/next buffer |
| `[j` / `]j` | Previous/next jump |
| `[i` / `]i` | Indent scope top/bottom |
| `[Q` / `]Q` | First/last quickfix |

## mini.comment

| Key | Description |
|-----|-------------|
| `gcc` | Toggle comment line |
| `gc{motion}` | Toggle comment motion |
| `gc` (Visual) | Toggle comment selection |

## mini.surround (`s` prefix)

| Key | Description |
|-----|-------------|
| `sa{motion}{char}` | Surround add |
| `sd{char}` | Surround delete |
| `sr{old}{new}` | Surround replace |
| `sf{char}` | Surround find |
| `sh{char}` | Surround highlight |

**Examples:** `saiw)` (surround word with parens), `sdf` (delete function call)

## mini.operators

| Key | Description |
|-----|-------------|
| `gr{motion}` / `grr` | Replace with register |
| `gm{motion}` / `gmm` | Multiply/duplicate |
| `gs{motion}` | Sort |
| `gx{motion}` | Exchange |
| `g={motion}` / `g==` | Evaluate as Lua |
| `(` / `)` | Swap argument left/right |

## mini.ai Textobjects

| Key | Description |
|-----|-------------|
| `a)`/`i)` | Around/inside parentheses |
| `aq`/`iq` | Around/inside any quote |
| `af`/`if` | Around/inside function call |
| `aa`/`ia` | Around/inside argument |
| `aB`/`iB` | Around/inside buffer |
| `aF`/`iF` | Around/inside function def |
| `an`/`in` | Next variant |
| `al`/`il` | Last (previous) variant |

## mini.diff Hunks

| Key | Description |
|-----|-------------|
| `gh{motion}` | Apply hunks |
| `gH{motion}` | Reset hunks |
| `ghgh` / `gHgh` | Apply/reset hunk at cursor |

## mini.move

| Key | Description |
|-----|-------------|
| `<M-j>` / `<M-k>` | Move line down/up |
| `<M-h>` / `<M-l>` | Decrease/increase indent |
| `<M-h/j/k/l>` (Visual) | Move selection |

## mini.jump

| Key | Description |
|-----|-------------|
| `f/F{char}` | Jump forward/backward to char |
| `t/T{char}` | Jump till char |
| `<CR>` | Start jump2d (label jumping) |

## mini.splitjoin / mini.align

| Key | Description |
|-----|-------------|
| `gS` | Toggle split/join arguments |
| `ga{motion}{char}` | Align by character |
| `gA{motion}` | Interactive alignment |

## mini.files Explorer

| Key | Description |
|-----|-------------|
| `l` / `h` | Go in / go out |
| `o` | Create new entry |
| `C` | Rename |
| `dd` / `yy` / `p` | Delete / copy / paste |
| `=` | Synchronize changes |
| `'c` / `'p` / `'w` | Bookmarks: config/plugins/cwd |
| `g?` | Show help |

## Completion & Snippets (Insert mode)

| Key | Description |
|-----|-------------|
| `<Tab>` / `<S-Tab>` | Navigate completion |
| `<CR>` | Accept completion |
| `<C-e>` | Discard completion |
| `<C-j>` | Expand snippet |
| `<C-l>` / `<C-h>` | Next/prev tabstop |

## mini.pick (Picker)

| Key | Description |
|-----|-------------|
| `<C-n>` / `<C-p>` | Navigate down/up |
| `<Tab>` | Toggle preview |
| `<S-Tab>` | Show picker info |
| `<CR>` | Choose item |
| `<Esc>` | Close picker |

## Window Management (`<C-w>`)

| Key | Description |
|-----|-------------|
| `<C-w>s` | Horizontal split |
| `<C-w>v` | Vertical split |
| `<C-w>+` / `-` | Increase/decrease height (submode) |
| `<C-w><` / `>` | Decrease/increase width |

*With mini.clue, after `<C-w>+`, keep pressing `+`/`-` without `<C-w>`*
