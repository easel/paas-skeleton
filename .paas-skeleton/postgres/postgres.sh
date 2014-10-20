echo -n "Checking for pg_config: "
if which -s pg_config > /dev/null; then
    echo "installed and on path"
else
    if [[ "$PAAS_SKELETON_PLATFORM" == "mac" ]]; then
        check_and_add_path_entry "/Applications/Postgres.app/Contents/MacOS/bin"
        check_and_add_dyld_library_path_entry "/Applications/Postgres.app/Contents/MacOS/bin"
        check_and_add_path_entry "/Applications/Postgres.app/Contents/Versions/9.3/bin"
        check_and_add_dyld_library_path_entry "/Applications/Postgres.app/Contents/Versions/9.3/lib"
        check_and_add_dyld_library_path_entry "/usr/lib"
    fi
    if which -s pg_config > /dev/null; then
        echo "Rechecking for pg_config: installed and on path"
    else
        echo "MISSING - try 'brew cask install postgres'"
    fi
fi

