bindkey -e
export EDITOR=vim

export PATH=/usr/local/bin:$PATH
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH=$HOME/Library/Android/sdk/platform-tools:$PATH

# Alias
alias ls='ls -G'
alias diff='colordiff'
alias ll='ls -G -A -h -l -F'
alias gvim='open -a MacVim'
alias adobe='open -a Adobe\ Reader'
alias adblayout='adb shell setprop debug.layout'
alias hugon='hugo new --editor="code"'

HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000
autoload -U compinit
compinit
setopt auto_cd
setopt correct
setopt auto_list
setopt always_to_end
setopt nonomatch

# ignorecase, but smartcase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
autoload colors
colors
#PROMPT="%{${fg[yellow]}%}%~%{${fg[cyan]}%} %(!.#.$) %{${reset_color}%}"
PROMPT="%{${fg[yellow]}%}%1d%{${fg[cyan]}%} %(!.#.$) %{${reset_color}%}"

#
alias vimr='vim -R'
