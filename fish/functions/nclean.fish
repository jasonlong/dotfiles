# Defined via `source`
function nclean --wraps='rm -rf node_modules/; rm package-lock.json; npm i' --description 'alias nclean=rm -rf node_modules/; rm package-lock.json; npm i'
  rm -rf node_modules/; rm package-lock.json; npm i $argv; 
end
