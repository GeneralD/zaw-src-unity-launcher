#!/usr/bin/env zsh

function zaw-src-unity() {
    candidates=("${(@f)$(\ls -d1 $ZAW_UNITY_PATH/*/Unity.app 2>/dev/null)}")
    if which map 1>/dev/null; then # <- zsh-functional plugin is required
        local space=$'\uf116'
        local unity=$'\ue721'
        [[ $#candidates > 0 ]] && cand_descriptions=(`mdls -name kMDItemVersion $ZAW_UNITY_PATH/*/Unity.app | map '$unity$space$1:gs/kMDItemVersion = "Unity version //:gs/"//'`)
    fi
    actions=('zaw-callback-launch-macapp' 'zaw-src-unity-proj' 'zaw-src-unity-remove' 'zaw-callback-append-to-buffer' 'zaw-callback-replace-buffer')
    act_descriptions=('launch' 'open current directory' 'uninstall' 'append to edit buffer' 'replace edit buffer')
}

function zaw-src-unity-proj() {
    if [[ -f ./ProjectSettings/ProjectVersion.txt ]]; then
        BUFFER="\"${(j:; :)@}Contents/MacOS/Unity\" -projectPath \"$(pwd)\" &"
    else
        echo "\033[0;33mHere is not Unity project root!"
    fi
    zle accept-line
}

function zaw-src-unity-remove() {
    local dir=`dirname ${(j:; :)@}`
    echo "\033[0;33mDo you want to remove $dir? (y/n)"
    if read -qs && BUFFER="sudo rm -rf \"$dir\""
    zle accept-line
}

zaw-register-src -n unity zaw-src-unity