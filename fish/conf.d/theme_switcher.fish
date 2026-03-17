# Auto-detect macOS appearance on every prompt and switch starship + fish theme
function __theme_switcher --on-event fish_prompt
    if defaults read -g AppleInterfaceStyle &>/dev/null
        if test "$__current_theme" != dark
            set -g __current_theme dark
            set -gx STARSHIP_CONFIG ~/dev/dotfiles/starship/starship-poimandres-dark.toml
            source ~/dev/dotfiles/fish/themes/poimandres.theme
        end
    else
        if test "$__current_theme" != light
            set -g __current_theme light
            set -gx STARSHIP_CONFIG ~/dev/dotfiles/starship/starship-poimandres-storm.toml
            source ~/dev/dotfiles/fish/themes/poimandres_storm.theme
        end
    end
end
