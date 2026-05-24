function sync_hunk_theme
    mkdir -p ~/.config/hunk

    if defaults read -g AppleInterfaceStyle &>/dev/null
        ln -sf ~/dev/dotfiles/hunk/config-dark.toml ~/.config/hunk/config.toml
    else
        ln -sf ~/dev/dotfiles/hunk/config-storm.toml ~/.config/hunk/config.toml
    end
end
