#!/bin/bash
set -e

DOTFILES="$HOME/dev/dotfiles"

# Helper: symlink a directory, backing up any existing non-symlink
link_dir() {
  local src="$1" dest="$2"
  if [ -L "$dest" ]; then
    rm "$dest"
  elif [ -d "$dest" ]; then
    echo "  Backing up existing $dest to ${dest}.bak"
    mv "$dest" "${dest}.bak"
  fi
  ln -s "$src" "$dest"
  echo "  $dest -> $src"
}

# Helper: symlink a file, backing up any existing non-symlink
link_file() {
  local src="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [ -L "$dest" ]; then
    rm "$dest"
  elif [ -f "$dest" ]; then
    echo "  Backing up existing $dest to ${dest}.bak"
    mv "$dest" "${dest}.bak"
  fi
  ln -s "$src" "$dest"
  echo "  $dest -> $src"
}

echo "Linking dotfiles..."

# Directory symlinks into ~/.config/
link_dir "$DOTFILES/fish"     "$HOME/.config/fish"
link_dir "$DOTFILES/nvim"     "$HOME/.config/nvim"
link_dir "$DOTFILES/ghostty"  "$HOME/.config/ghostty"
link_dir "$DOTFILES/skhd"     "$HOME/.config/skhd"
link_dir "$DOTFILES/yabai"    "$HOME/.config/yabai"

# Hammerspoon lives in ~/
link_dir "$DOTFILES/hammerspoon" "$HOME/.hammerspoon"

# Individual file symlinks
link_file "$DOTFILES/git/.gitconfig"        "$HOME/.gitconfig"
link_file "$DOTFILES/git/.gitignore_global" "$HOME/.gitignore_global"
link_file "$DOTFILES/git/.gitalias.txt"     "$HOME/.gitalias.txt"
link_file "$DOTFILES/tmux/.tmux.conf"       "$HOME/.tmux.conf"
link_file "$DOTFILES/starship/starship.toml" "$HOME/.config/starship.toml"
link_file "$DOTFILES/gh/config.yml"         "$HOME/.config/gh/config.yml"

echo "Done!"
