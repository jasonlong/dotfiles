function llt --wraps='exa -l --tree --level=2 --no-permissions --no-user --group-directories-first' --description 'alias llt=exa -l --tree --level=2 --no-permissions --no-user --group-directories-first'
  exa -l --tree --level=2 --no-permissions --no-user --group-directories-first $argv
        
end
