fish_vi_key_bindings

# Source secrets (not in version control)
test -f ~/.config/fish/secrets.fish && source ~/.config/fish/secrets.fish

# Poimandres theme — auto dark/storm based on macOS appearance
if defaults read -g AppleInterfaceStyle &>/dev/null
    set -gx STARSHIP_CONFIG ~/dev/dotfiles/starship/starship-poimandres-dark.toml
    source ~/dev/dotfiles/fish/themes/poimandres.theme
else
    set -gx STARSHIP_CONFIG ~/dev/dotfiles/starship/starship-poimandres-storm.toml
    source ~/dev/dotfiles/fish/themes/poimandres_storm.theme
end

alias g='git'
alias ss='script/server'
alias rc='rails console'
alias api='cd ~/dev/api-bb/'
alias app='cd ~/dev/app-bb/'
alias v='nvim'
alias lg='lazygit'
alias t='tmux-sessionizer'
alias h='cht.sh'
alias oc='opencode'

set -gx DFT_WIDTH 160

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

# thefuck
thefuck --alias | source
fish_add_path $HOME/.local/bin
direnv hook fish | source
alias cc='claude --dangerously-skip-permissions'
