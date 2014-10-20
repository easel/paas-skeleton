function check_and_add_path_entry() {
    if [[ -d $1 ]]; then
        echo "installed at $1, added to PATH"
        export PATH="$1:$PATH"
    fi
}

function check_and_add_dyld_library_path_entry() {
    if [[ -d $1 ]]; then
        echo "installed at $1, added to DYLD_FALLBACK_LIBRARY_PATH"
        export DYLD_FALLBACK_LIBRARY_PATH="$1:$DYLD_FALLBACK_LIBRARY_PATH"
    fi
}

install_apt_packages(){
    for package_name in $1
    do
        # PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $package_name|grep "install ok installed")

        # if [ "" == "$PKG_OK" ]; then
        #     sudo apt-get --force-yes --yes install $package_name
        # else
        #     echo "${package_name} already installed!"
        # fi
        run_with_confirmation "sudo apt-get --force-yes --yes install $package_name"

    done
}

install_brew_packages(){
    if [ -n "$ZSH_VERSION" ]; then
        eval "packages=($1)"
    else
        packages=$1
    fi
    for package_name in $packages
    do
        echo -n "Checking for $package_name: "
        if brew ls $package_name > /dev/null 2>&1; then
           echo "installed"
        else
           echo "MISSING: try brew install $package_name"
        fi
    done
}

run_with_confirmation(){
    if [[ "${AUTO_AGREE}" == "true" ]]; then
        echo
        echo "You are missing critical dependencies, and --auto-agree is true, executing $1"
        eval $1
        echo
    else
        echo
        echo "You are missing critical dependencies, you will need to execute: "
        echo "$1"
        echo
    fi
}
