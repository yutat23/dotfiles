bindkey -e
export EDITOR=vim

export PATH=/usr/local/bin:$PATH
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH=$HOME/Library/Android/sdk/platform-tools:$PATH

# Alias
alias ls='ls -G'
alias diff='colordiff'
alias ll='ls -G -A -h -l -F'

HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups
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

#path
export PATH=$PATH:/home/ytkmr/.cargo/bin

#apt
source /etc/zsh_command_not_found

#alias
if type exa >/dev/null 2>&1; then
  alias l='exa'
  alias ll='exa -la'
else
  alias l='ls --color=auto'
  alias ll='ls --color=auto -la'
fi

alias vimr='vim -R'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

function chpwd() { exa }

#proxy
if [ -e ~/dotfiles/setProxy.sh ]; then
  chmod +x ~/dotfiles/setProxy.sh
  source ~/dotfiles/setProxy.sh
fi

