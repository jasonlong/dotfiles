# Ensure new interactive shells honor the configured nvm.fish default,
# even when an older nvm_current_version is inherited from a parent shell/app.
if status is-interactive; and set --query nvm_default_version
    set --local node_path (command --search node)

    if test "$nvm_current_version" != "$nvm_default_version"; or not string match --quiet -- "$nvm_data/$nvm_default_version/bin/*" $node_path
        nvm use --silent $nvm_default_version
    end
end
