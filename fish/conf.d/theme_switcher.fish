# Auto-detect macOS appearance changes and update theme
function _theme_check --on-event fish_prompt
    set -l appearance (defaults read -g AppleInterfaceStyle 2>/dev/null)

    # Determine target config based on appearance
    if test "$appearance" = "Dark"
        set -l target_config ~/dev/dotfiles/starship/starship-gruvbox-dark.toml
        set -l target_theme gruvbox_material_dark
        if test "$STARSHIP_CONFIG" != "$target_config"
            set -gx STARSHIP_CONFIG $target_config
            fish_config theme choose $target_theme
        end
    else
        set -l target_config ~/dev/dotfiles/starship/starship-gruvbox-light.toml
        set -l target_theme gruvbox_material_light
        if test "$STARSHIP_CONFIG" != "$target_config"
            set -gx STARSHIP_CONFIG $target_config
            fish_config theme choose $target_theme
        end
    end
end
