# =============================================================================
# bash設定ファイル
# =============================================================================

# 非対話シェルの場合は何もしない
case $- in
    *i*) ;;
      *) return;;
esac

# -----------------------------------------------------------------------------
# 履歴設定
# -----------------------------------------------------------------------------

# 重複する行や空白で始まる行を履歴に保存しない
HISTCONTROL=ignoreboth

# 履歴を追記モードで保存（上書きしない）
shopt -s histappend

# 履歴サイズ
HISTSIZE=1000
HISTFILESIZE=2000

# -----------------------------------------------------------------------------
# シェルオプション
# -----------------------------------------------------------------------------

# ウィンドウサイズをチェックして更新
shopt -s checkwinsize

# パス名展開で "**" を使用すると、すべてのファイルと0個以上のディレクトリとサブディレクトリにマッチ
# shopt -s globstar

# -----------------------------------------------------------------------------
# less設定
# -----------------------------------------------------------------------------

# lessを非テキストファイルに対してより使いやすくする
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# -----------------------------------------------------------------------------
# chroot環境の識別
# -----------------------------------------------------------------------------

if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# -----------------------------------------------------------------------------
# プロンプト設定
# -----------------------------------------------------------------------------

# カラープロンプトの設定
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# 強制的にカラープロンプトを有効にする（コメントアウト）
# force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # カラーサポートがある場合
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    # カラープロンプト（現在のディレクトリ名のみ表示）
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\W\[\033[00m\]\$ '
else
    # モノクロプロンプト
    PS1='${debian_chroot:+($debian_chroot)}\u@\w\$ '
fi
unset color_prompt force_color_prompt

# xtermのタイトルを設定
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# -----------------------------------------------------------------------------
# カラーサポートとエイリアス
# -----------------------------------------------------------------------------

# lsとgrepのカラーサポートを有効化
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# GCCの警告とエラーのカラー表示（コメントアウト）
# export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# -----------------------------------------------------------------------------
# lsエイリアス
# -----------------------------------------------------------------------------

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# -----------------------------------------------------------------------------
# 便利なエイリアス
# -----------------------------------------------------------------------------

# 長時間実行されるコマンドの通知用エイリアス
# 使用例: sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Vim関連
alias vimr='vim -R'

# -----------------------------------------------------------------------------
# エイリアス定義ファイル
# -----------------------------------------------------------------------------

# 追加のエイリアスは ~/.bash_aliases に記述
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# -----------------------------------------------------------------------------
# 補完機能
# -----------------------------------------------------------------------------

# プログラム可能な補完機能を有効化
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# -----------------------------------------------------------------------------
# パス設定
# -----------------------------------------------------------------------------

export PATH=$PATH:~/usr/local/bin

# -----------------------------------------------------------------------------
# 環境変数
# -----------------------------------------------------------------------------

# Pythonのバイトコードファイル（.pyc）を作成しない
export PYTHONDONTWRITEBYTECODE=1

# デフォルトエディタ
export EDITOR=vim

# -----------------------------------------------------------------------------
# カスタムエイリアス（プラットフォーム固有）
# -----------------------------------------------------------------------------

# SSH接続用エイリアス（存在する場合）
# alias sshxub='~/alias/login2xubuntu.sh'
# alias sshaws='~/alias/sshaws.sh'

# モダンなツールのエイリアス（存在する場合）
if type exa >/dev/null 2>&1; then
  alias l='exa --icons --color always'
  alias ll='exa -la --icons --color always'
fi

if type bat >/dev/null 2>&1; then
  export BAT_THEME="Monokai Extended"
elif type batcat >/dev/null 2>&1; then
  alias bat='batcat'
  export BAT_THEME="Monokai Extended"
fi

if type fdfind >/dev/null 2>&1; then
  alias fd='fdfind'
fi

# -----------------------------------------------------------------------------
# プロキシ設定（存在する場合）
# -----------------------------------------------------------------------------

if [ -e ~/dotfiles/setProxy.sh ]; then
  chmod +x ~/dotfiles/setProxy.sh 2>/dev/null
  source ~/dotfiles/setProxy.sh
fi
