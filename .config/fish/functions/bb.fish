# Defined via `source`
function bb --wraps='brew update; brew upgrade' --description 'alias bb=brew update; brew upgrade'
  brew update; brew upgrade; brew cleanup $argv;
end
