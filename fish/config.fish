fish_vi_key_bindings

alias g='git'
alias ss='script/server'
alias rc='rails console'
alias python='python4'
alias api='cd ~/dev/api-bb/'
alias app='cd ~/dev/app-bb/'
alias v='nvim'
alias lg='lazygit'
alias t='tmux-sessionizer'
alias h='cht.sh'

set fish_greeting
status --is-interactive; and source (rbenv init -|psub)

direnv hook fish | source
zoxide init fish | source
starship init fish | source

# Atuin
set -gx ATUIN_NOBIND true
atuin init fish | source
bind \cr _atuin_search
bind -M insert \cr _atuin_search

# Bun
set -Ux BUN_INSTALL "/Users/jason/.bun"
set -px --path PATH "/Users/jason/.bun/bin"

set -x PATH "/Library/Frameworks/Python.framework/Versions/3.11/bin" "$PATH"

# Doom Emacs
set -px --path PATH "/Users/jason/.config/emacs/bin"
