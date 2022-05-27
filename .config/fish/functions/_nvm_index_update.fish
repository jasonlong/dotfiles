function _nvm_index_update -a mirror index
    command curl --location --silent $mirror | command awk -v OFS=\t '
        /v0.9.12/ { exit } # Unsupported
        NR > 1 {
            print $1 (NR == 2  ? " latest" : $10 != "-" ? " lts/" tolower($10) : "")
        }
    ' > $index.temp && command mv $index.temp $index && return 
    
    command rm -f $index.temp
    echo "nvm: Invalid index or unavailable host: \"$mirror\"" >&2
    return 1
end