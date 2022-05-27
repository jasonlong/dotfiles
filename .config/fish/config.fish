fish_vi_key_bindings

alias g='git'
alias ss='script/server'
alias rc='rails console'
alias python='python3'
alias api='cd ~/dev/api-bb/'
alias app='cd ~/dev/app-bb/'
alias v='nvim'
alias lg='lazygit'

set fish_greeting
status --is-interactive; and source (rbenv init -|psub)

direnv hook fish | source
mcfly init fish | source
zoxide init fish | source
starship init fish | source

# Setting PATH for Python 3.10
# The original version is saved in /Users/jason/.config/fish/config.fish.pysave
set -x PATH "/Library/Frameworks/Python.framework/Versions/3.10/bin" "$PATH"
