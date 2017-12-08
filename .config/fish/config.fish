# Tell fzf to not use files ignored by git, etc.
set -x FZF_DEFAULT_COMMAND 'rg --files'

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[ -f /usr/local/lib/node_modules/electron-forge/node_modules/tabtab/.completions/electron-forge.fish ]; and . /usr/local/lib/node_modules/electron-forge/node_modules/tabtab/.completions/electron-forge.fish