# Defined via `source`
function bclean --wraps=git\ branch\ --merged\ \|\ egrep\ -v\ \"\(\^\\\*\|master\|main\)\"\ \|\ xargs\ git\ branch\ -d --description alias\ bclean=git\ branch\ --merged\ \|\ egrep\ -v\ \"\(\^\\\*\|master\|main\)\"\ \|\ xargs\ git\ branch\ -d
  git branch --merged | egrep -v "(^\*|master|main)" | xargs git branch -d $argv; 
end
