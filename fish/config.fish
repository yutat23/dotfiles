#alias
alias watch="watch -c "

if type exa >/dev/null 2>&1;
  alias l='exa --icons --color always'
  alias ll='exa -la --icons --color always'
else
  alias l='ls --color=auto'
  alias ll='ls --color=auto -la'
end

if type bat >/dev/null 2>&1;
  export BAT_THEME="Monokai Extended"
end

if type fdfind >/dev/null 2>&1;
  alias fd='fdfind'
end


if type batcat >/dev/null 2>&1;
  alias bat='batcat'
end

if type rgrep >/dev/null 2>&1;
  alias rg='rgrep -n --color'
end

alias vimr='vim -R'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

#peco setting
set fish_plugins theme peco

function fish_user_key_bindings
bind \cw peco_select_history
end

# Base16 Shell
if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"
end

base16-monokai