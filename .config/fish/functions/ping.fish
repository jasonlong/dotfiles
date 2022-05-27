# Defined via `source`
function ping --wraps='prettyping --nolegend ' --description 'alias ping=prettyping --nolegend '
  prettyping --nolegend  $argv; 
end
