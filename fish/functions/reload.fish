function reload
    # Help
    function __help -d "show help"
        printf "usage: reload [-h] [-c command] [-e 'env1=value1'] [-e 'env2=value2']\n\n"

        printf "positional arguments:\n"
        printf "\n"

        printf "optional arguments:\n"
        printf "  -h, --help          show this help message and exit\n"
        printf "  -c, --command       command to be executed before reloading\n"
        printf "  -e, --env           environment variable to be set before reloading\n"
        printf "\n"

        return 0
    end

    # Parse arguments
    set -l options h/help "c/command=" "e/env=+"
    argparse $options -- $argv || return 1

    # Show help
    set -q _flag_help && __help && return 0

    # Create unset options
    for env_var in (env)
        set key (string split = "$env_var")[1]
        if not contains "$key" $RELOAD_PROTECTED_ENV_VARS
            set unset_options $unset_options -u $key
        end
    end

    # Execute command
    set -q _flag_command && eval $_flag_command >/dev/null 2>&1

    # Evaluate env
    for env_var in $_flag_env
        set key (string split = "$env_var")[1]
        set value (string split = "$env_var")[2]

        set re_evaluated (fish -c "echo $value")
        set -a envs "$key=$re_evaluated"
    end

    # Reload shell
    exec env $unset_options /usr/bin/env $envs bash -i -c "exec fish"
end
