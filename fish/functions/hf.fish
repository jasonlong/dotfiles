# Defined via `source`
function hf --wraps='history | fzf' --description 'alias hf=history | fzf'
  history | fzf $argv; 
end
