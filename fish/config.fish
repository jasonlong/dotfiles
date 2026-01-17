fish_vi_key_bindings

# Auto-switch theme based on macOS appearance
set -l appearance (defaults read -g AppleInterfaceStyle 2>/dev/null)
if test "$appearance" = "Dark"
    fish_config theme choose poimandres_dark
    set -gx STARSHIP_CONFIG ~/dev/dotfiles/starship/starship-poimandres-dark.toml
else
    fish_config theme choose poimandres_light
    set -gx STARSHIP_CONFIG ~/dev/dotfiles/starship/starship-poimandres-light.toml
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
fish_add_path "/Users/jason/.local/share/bob/nvim-bin"

# thefuck
thefuck --alias | source
alias claude="/Users/jason/.claude/local/claude"
fish_add_path $HOME/.local/bin
direnv hook fish | source
alias cc='claude --dangerously-skip-permissions'
