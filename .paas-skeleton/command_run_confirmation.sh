#!/bin/bash

run_with_confirmation(){
    if [[ "${AUTO_AGREE}" == "true" ]]; then
        echo
        echo "You are missing critical dependencies, and --auto-agree is true, executing $1"
        eval $1
        echo
    else
        echo
        echo "You are missing critical dependencies, you will need to execute: "
        echo "$1?"
        echo
    fi
}
