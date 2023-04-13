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

# TokyoNight Color Palette
# set -l foreground c8d3f5
# set -l selection 3654a7
# set -l comment 636da6
# set -l red ff757f
# set -l orange ff966c
# set -l yellow ffc777
# set -l green c3e88d
# set -l purple fca7ea
# set -l cyan 86e1fc
# set -l pink c099ff

# Syntax Highlighting Colors
# set -g fish_color_normal $foreground
# set -g fish_color_command $cyan
# set -g fish_color_keyword $pink
# set -g fish_color_quote $yellow
# set -g fish_color_redirection $foreground
# set -g fish_color_end $orange
# set -g fish_color_error $red
# set -g fish_color_param $purple
# set -g fish_color_comment $comment
# set -g fish_color_selection --background=$selection
# set -g fish_color_search_match --background=$selection
# set -g fish_color_operator $green
# set -g fish_color_escape $pink
# set -g fish_color_autosuggestion $comment

# Completion Pager Colors
# set -g fish_pager_color_progress $comment
# set -g fish_pager_color_prefix $cyan
# set -g fish_pager_color_completion $foreground
# set -g fish_pager_color_description $comment
# set -g fish_pager_color_selected_background --background=$selection
