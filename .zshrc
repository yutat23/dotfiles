bindkey -e
export EDITOR=vim

export PATH=/usr/local/bin:$PATH
#export PATH=$HOME/.nodebrew/current/bin:$PATH
#export PATH=$HOME/Library/Android/sdk/platform-tools:$PATH

# Alias
alias ls='ls -G'
alias diff='colordiff'
alias ll='ls -G -A -h -l -F'

HISTFILE=$HOME/.zsh_history
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
#PROMPT="%{${fg[yellow]}%}%1d%{${fg[cyan]}%} %(!.#.$) %{${reset_color}%}"
PROMPT="%{${fg[yellow]}%}%~%{${fg[cyan]}%}
%B%(!.濫.)%b %{${reset_color}%}"

#path
#export PATH=$PATH:~/.cargo/bin
export PATH=$PATH:~/dotfiles/mybin
export PATH=$PATH:~/.local/bin

#tmux
if [[ ! -n $TMUX && $- == *l* ]]; then
  # get the IDs
  ID="`tmux list-sessions`"
  if [[ -z "$ID" ]]; then
    tmux new-session
  fi
  create_new_session="Create New Session"
  ID="$ID\n${create_new_session}:"
  ID="`echo $ID | $PERCOL | cut -d: -f1`"
  if [[ "$ID" = "${create_new_session}" ]]; then
    tmux new-session
  elif [[ -n "$ID" ]]; then
    tmux attach-session -t "$ID"
  else
    :  # Start terminal normally
  fi
fi

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
  [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
  eval "$("$BASE16_SHELL/profile_helper.sh")"

base16_monokai

#apt
#source /etc/zsh_command_not_found

#alias
alias watch="watch -c "

if type exa >/dev/null 2>&1; then
  alias l='exa --icons --color always'
  alias ll='exa -la --icons --color always'
else
  alias l='ls --color=auto'
  alias ll='ls --color=auto -la'
fi

if type bat >/dev/null 2>&1; then
  export BAT_THEME="Monokai Extended"
fi

if type fdfind >/dev/null 2>&1; then
  alias fd='fdfind'
fi


if type batcat >/dev/null 2>&1; then
  alias bat='batcat'
fi

if type rgrep >/dev/null 2>&1; then
  alias rg='rgrep -n --color'
fi

alias vimr='vim -R'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

function chpwd() { l }

function mkdircd(){ mkdir -p "$@" && eval cd "\"\$$#\""; }

#proxy
if [ -e ~/dotfiles/setProxy.sh ]; then
  chmod +x ~/dotfiles/setProxy.sh
  source ~/dotfiles/setProxy.sh
fi

