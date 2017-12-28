#!/usr/bin/env zsh

# this plugin works on only macOS
[[ $OSTYPE != *darwin* ]] && return

if [[ -n `declare -f -F zaw-register-src` ]]; then
    for s in $0:A:h/src/*.zsh; do
        source $s
    done
else
    echo "Please load zaw before loading any zaw source plugins."
fi