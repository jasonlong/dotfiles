function ll --wraps='exa -l --no-permissions --no-user --group-directories-first' --description 'alias ll=exa -l --no-permissions --no-user --group-directories-first'
  exa -l --no-permissions --no-user --group-directories-first $argv
        
end
