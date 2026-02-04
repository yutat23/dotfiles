# =============================================================================
# zsh設定ファイル
# =============================================================================

# -----------------------------------------------------------------------------
# 基本設定
# -----------------------------------------------------------------------------

# Emacs風キーバインド
bindkey -e

# デフォルトエディタ
export EDITOR=vim

# -----------------------------------------------------------------------------
# パス設定
# -----------------------------------------------------------------------------

# システムパス
export PATH=/usr/local/bin:$PATH

# カスタムスクリプト
export PATH=$PATH:~/dotfiles/mybin

# ローカルバイナリ
export PATH=$PATH:~/.local/bin


export ADOC_HOME="$HOME/.adoc"
[ -f "/Users/yutat23/.ghcup/env" ] && . "/Users/yutat23/.ghcup/env" # ghcup-env


# プラットフォーム固有のパス設定（必要に応じてコメントアウトを解除）
# export PATH=$HOME/.nodebrew/current/bin:$PATH
# export PATH=$HOME/Library/Android/sdk/platform-tools:$PATH
# export PATH=$PATH:~/.cargo/bin

# -----------------------------------------------------------------------------
# 履歴設定
# -----------------------------------------------------------------------------

HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# 履歴の重複を無視
setopt hist_ignore_dups
# 履歴を共有
setopt share_history
# 履歴に時刻を記録
setopt extended_history
# 履歴検索で重複を無視
setopt hist_find_no_dups
# 履歴から重複を削除
setopt hist_ignore_all_dups
# 履歴をインクリメンタルに追加
setopt inc_append_history

# -----------------------------------------------------------------------------
# 補完設定
# -----------------------------------------------------------------------------

# 補完機能を有効化（安全に実行）
autoload -U compinit
# 補完システムを初期化（既に初期化されている場合はスキップ）
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# 補完候補を自動的に選択
setopt auto_list
# 補完候補を選択したら自動的に移動
setopt always_to_end
# 補完候補を詰めて表示
setopt list_packed
# 補完候補を色分け
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# 大文字小文字を区別しない（ただし、大文字が含まれている場合は区別）
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# 補完候補をグループ化
zstyle ':completion:*' group-name ''

# -----------------------------------------------------------------------------
# その他のオプション
# -----------------------------------------------------------------------------

# ディレクトリ名だけでcd
setopt auto_cd
# コマンドのスペルチェック（対話的でない場合は無効化）
[[ -o interactive ]] && setopt correct
# グロブパターンでマッチしない場合もエラーにしない
setopt nonomatch
# バックグラウンドジョブの状態を即座に報告
setopt notify

# -----------------------------------------------------------------------------
# プロンプト設定
# -----------------------------------------------------------------------------

# カラーを有効化
autoload colors
colors

# カスタムプロンプト（現在のディレクトリ + 記号）
PROMPT="%{${fg[yellow]}%}%~%{${fg[cyan]}%}
%B%(!.⚡.❯)%b %{${reset_color}%}"

# 代替プロンプト（コメントアウト）
# PROMPT="%{${fg[yellow]}%}%~%{${fg[cyan]}%} %(!.#.$) %{${reset_color}%}"
# PROMPT="%{${fg[yellow]}%}%1d%{${fg[cyan]}%} %(!.#.$) %{${reset_color}%}"

# -----------------------------------------------------------------------------
# エイリアス
# -----------------------------------------------------------------------------

# 基本コマンド
alias ls='ls -G'
alias diff='colordiff'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias watch="watch -c "

# Vim関連
alias vimr='vim -R'

# モダンなツールのエイリアス（存在する場合）
if type eza >/dev/null 2>&1; then
  alias l='eza --icons --color always'
  alias ll='eza -la --icons --color always'
else
  alias l='ls --color=auto'
  alias ll='ls --color=auto -la'
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

if type rgrep >/dev/null 2>&1; then
  alias rg='rgrep -n --color'
fi

# -----------------------------------------------------------------------------
# 関数
# -----------------------------------------------------------------------------

# ディレクトリ変更時に自動的にlsを実行（安全に実行）
function chpwd() {
  if type l >/dev/null 2>&1 || type eza >/dev/null 2>&1 || type ls >/dev/null 2>&1; then
    l 2>/dev/null || true
  fi
}

# ディレクトリを作成して移動
function mkdircd() {
  mkdir -p "$@" && eval cd "\"\$$#\""
}

# -----------------------------------------------------------------------------
# tmux自動起動（オプション - 必要に応じてコメントアウトを解除）
# -----------------------------------------------------------------------------

# ログインシェルで、tmuxセッション内でない場合のみ実行
# 注意: この機能を有効にすると、zsh起動時に自動的にtmuxが起動します
# 無効にする場合は、以下のブロック全体をコメントアウトしてください
# if [[ ! -n $TMUX && $- == *l* ]] && [[ -z "$SSH_CLIENT" ]] && [[ -z "$SSH_TTY" ]]; then
#   # 既存のセッションを取得
#   ID="`tmux list-sessions 2>/dev/null`"
#   
#   if [[ -z "$ID" ]]; then
#     # セッションが存在しない場合は新規作成
#     exec tmux new-session
#   elif type percol >/dev/null 2>&1; then
#     # percolが利用可能な場合はセッション選択
#     create_new_session="Create New Session"
#     ID="$ID\n${create_new_session}:"
#     ID="`echo $ID | percol | cut -d: -f1`"
#     
#     if [[ "$ID" = "${create_new_session}" ]]; then
#       exec tmux new-session
#     elif [[ -n "$ID" ]]; then
#       exec tmux attach-session -t "$ID"
#     fi
#   else
#     # percolが利用できない場合は最初のセッションにアタッチ
#     exec tmux attach-session -t $(echo $ID | head -1 | cut -d: -f1)
#   fi
# fi

# -----------------------------------------------------------------------------
# Base16 Shell（カラースキーム）
# -----------------------------------------------------------------------------

BASE16_SHELL="$HOME/.config/base16-shell/"
if [ -n "$PS1" ] && [ -s "$BASE16_SHELL/profile_helper.sh" ]; then
  eval "$("$BASE16_SHELL/profile_helper.sh")"
fi

# Monokaiテーマを適用（エラーを無視）
if type base16_monokai >/dev/null 2>&1; then
  base16_monokai 2>/dev/null || true
fi

# -----------------------------------------------------------------------------
# プラットフォーム固有の設定
# -----------------------------------------------------------------------------

# Debian/Ubuntu用のコマンド未検出メッセージ（必要に応じてコメントアウトを解除）
# if [ -f /etc/zsh_command_not_found ]; then
#   source /etc/zsh_command_not_found
# fi

# プロキシ設定（存在する場合）
if [ -e ~/dotfiles/setProxy.sh ]; then
  chmod +x ~/dotfiles/setProxy.sh 2>/dev/null
  source ~/dotfiles/setProxy.sh
fi
