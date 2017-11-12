function prompt_pwd_full --description 'Print the current working directory'
  echo $PWD | sed -e "s|^$HOME|~|" -e 's|^/private||'
end
