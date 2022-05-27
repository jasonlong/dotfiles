# Defined via `source`
function t --wraps='npm run lint && npm run tsc' --description 'alias t=npm run lint && npm run tsc'
  npm run lint && npm run tsc $argv; 
end
