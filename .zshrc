# 環境変数
export LANG=ja_JP.UTF-8

# 色を使用出来るようにする
autoload -Uz colors
colors

autoload -U compinit
compinit

# prompt
PROMPT='%n@%m:%c$ '

# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

alias la='ls -a'
alias ll='ls -l'


