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
sync_hunk_theme

abbr -a g git
abbr -a b but
abbr -a ss script/server
abbr -a rc "rails console"
abbr -a api "cd ~/dev/api-bb/"
abbr -a app "cd ~/dev/app-bb/"
abbr -a v nvim
abbr -a lg lazygit
abbr -a h cht.sh
abbr -a oc opencode
abbr -a q "pi --provider openai-codex --model gpt-5.4-mini --thinking off -p"

set -gx DFT_WIDTH 160
set -gx CLAUDE_CODE_NO_FLICKER 1 # Prevent mouse scrolling prompt history

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

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

# Mole shell completion
set -l output (mole completion fish 2>/dev/null); and echo "$output" | source
