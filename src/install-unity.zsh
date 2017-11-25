#!/usr/bin/env zsh

function zaw-src-install-unity() {
    local install_command=`install-unity-command`
    local l=`$install_command -l all | grep '^- [0-9]\+.[0-9]\+.[0-9]\+[fpb][0-9]\+'`
    local installed=(`echo $l | awk '$3 { print $2 }'`)
    candidates=(`echo $l | awk '!$3 { print $2 }'`)
    if which map 1>/dev/null; then # <- zsh-functional plugin is required
        local space=$'\uf116'
        local unity=$'\ue721'
        local downloaded=$'\uf019'
        print-icons() {
            [[ ${installed[(i)$1]} -le ${#installed} ]] && echo $space$downloaded
        }
        cand_descriptions=(`map '${unity}${space}$1$(print-icons $1)' $candidates`)
    fi
    actions=('zaw-src-install-unity-install' 'zaw-callback-append-to-buffer' 'zaw-callback-replace-buffer')
    act_descriptions=('install' 'append to edit buffer' 'replace edit buffer')
}

function zaw-src-install-unity-install() {
    local install_command=`install-unity-command`
    BUFFER="$install_command --all-packages ${(j:; :)@}"
    zle accept-line
}

zaw-register-src -n install-unity zaw-src-install-unity

install-unity-command() {
    # if you are using zplug, you can make install-unity enable as below
    # zplug "sttz/install-unity", as:command, use:'(*).py', rename-to:'$1'
    local command
    if which install-unity 1>/dev/null; then
        command=install-unity
    elif which ghq 1>/dev/null; then
        command=`ghq root`/github.com/sttz/install-unity/install-unity.py
        [[ -x $command ]] || ghq get sttz/install-unity
    else
        git clone https://github.com/sttz/install-unity.git ~/.install-unity
        command=~/.install-unity/install-unity.py
    fi
    echo $command
}
