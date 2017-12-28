# zaw-src-unity-launcher

Optional sources of [zaw](https://github.com/zsh-users/zaw) for Unity3d:

- unity
- install-unity

## Installation

If you are using zplug, just add the code below in your .zshrc.

```zsh
zplug "zsh-users/zaw"
zplug "GeneralD/zaw-src-unity-launcher", on:"zsh-users/zaw", on:"Tarrasch/zsh-functional", defer:2
zplug "Tarrasch/zsh-functional"

# if you don't add next line, necessary command will be installed automatically.
zplug "sttz/install-unity",\
  as:command,\
  use:'(*).py',\
  rename-to:'$1',\
  if:"[[ $OSTYPE == *darwin* ]]",\
  hook-build:"pyenv versions --bare 2>/dev/null \
            | gsort --version-sort --reverse \
            | egrep '2.[0-9]+.[0-9]+' \
            | head -n 1 \
            > $ZPLUG_REPOS/sttz/install-unity/.python-version"
```

For oh-my-zsh, clone this repo into ~/.oh-my-zsh/custom/plugins and add plugin as below.

```zsh
plugins+=(zaw zaw-src-unity-launcher zsh-functional)
```

## Customize

Unity installed directory is /Applications as default.
However, you can change the directory as below.

```zsh
ZAW_UNITY_PATH=~/Developer/Unity_Versions
```

### Caution

Above setting can change the directory to open Unity version you select. However, it doesn't change the destination of install-unity.

## Dependencies

- darwin
 
Currently, this compatible with only macOS.

- any nerd-font

This zaw source shows characters of nerd-font.
You can search compatible font with,

```sh
brew cask search nerd-font
```

Then, install and set any nerd-font to your terminal application.

## Trouble Shooting

- python causes error
 
To fix the error, cd to directory install-unity.py exists, then run

```sh
pyenv local 2.7.x
```

If you are using pyenv and installed [install-unity](https://github.com/sttz/install-unity) with zplug, hook-build part should fix it automatically.

