# Defined via `source`
function bb --wraps='brew update; brew upgrade' --description 'alias bb=brew update; brew upgrade'
  brew update; brew upgrade; brew cleanup $argv
  brew bundle dump --file=~/dev/dotfiles/Brewfile --describe --force
end
