function reload_theme
    set -l appearance (defaults read -g AppleInterfaceStyle 2>/dev/null)
    if test "$appearance" = "Dark"
        fish_config theme choose gruvbox_material_dark
        set -gx STARSHIP_CONFIG ~/dev/dotfiles/starship/starship-gruvbox-dark.toml
    else
        fish_config theme choose gruvbox_material_light
        set -gx STARSHIP_CONFIG ~/dev/dotfiles/starship/starship-gruvbox-light.toml
    end
    echo "Theme reloaded: "(test "$appearance" = "Dark"; and echo "dark"; or echo "light")
end
