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
mcfly init fish | source
zoxide init fish | source
starship init fish | source

set -x PATH "/Library/Frameworks/Python.framework/Versions/3.10/bin" "$PATH"

# Bun
set -Ux BUN_INSTALL "/Users/jason/.bun"
set -px --path PATH "/Users/jason/.bun/bin"

# Laravel Valet
set -px --path PATH "/Users/jason/.composer/vendor/bin"

