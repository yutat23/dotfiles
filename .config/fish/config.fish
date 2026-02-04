# =============================================================================
# fish設定ファイル
# =============================================================================

# -----------------------------------------------------------------------------
# 基本設定
# -----------------------------------------------------------------------------

# デフォルトエディタ
set -gx EDITOR vim

# -----------------------------------------------------------------------------
# パス設定
# -----------------------------------------------------------------------------

# カスタムスクリプト
set -gx PATH $PATH $HOME/dotfiles/mybin

# ローカルバイナリ
set -gx PATH $PATH $HOME/.local/bin

# システムパス
set -gx PATH /usr/local/bin $PATH

# -----------------------------------------------------------------------------
# エイリアス
# -----------------------------------------------------------------------------

# 基本コマンド
alias watch="watch -c "
alias vimr='vim -R'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# モダンなツールのエイリアス（存在する場合）
if type -q eza
  alias ls='eza --icons --color always'
  alias l='eza --icons --color always'
  alias ll='eza -la --icons --color always'
  alias lt='eza --tree --level=2 --icons'
else
  alias l='ls --color=auto'
  alias ll='ls --color=auto -la'
end

if type -q bat
  set -gx BAT_THEME "Monokai Extended"
else if type -q batcat
  alias bat='batcat'
  set -gx BAT_THEME "Monokai Extended"
end

if type -q fdfind
  alias fd='fdfind'
end

if type -q rgrep
  alias rg='rgrep -n --color'
end

# -----------------------------------------------------------------------------
# プラグイン設定
# -----------------------------------------------------------------------------

# peco設定（存在する場合）
if type -q peco
  set fish_plugins theme peco
  
  function fish_user_key_bindings
    bind \cw peco_select_history
  end
end

# -----------------------------------------------------------------------------
# Base16 Shell（カラースキーム）
# -----------------------------------------------------------------------------

if status --is-interactive
  set BASE16_SHELL "$HOME/.config/base16-shell/"
  if test -d "$BASE16_SHELL"
    source "$BASE16_SHELL/profile_helper.fish"
    base16-monokai 2>/dev/null
  end
end

# -----------------------------------------------------------------------------
# プロキシ設定（存在する場合）
# -----------------------------------------------------------------------------

if test -e $HOME/dotfiles/setProxy.sh
  chmod +x $HOME/dotfiles/setProxy.sh 2>/dev/null
  source $HOME/dotfiles/setProxy.sh
end

# -----------------------------------------------------------------------------
# その他の設定
# -----------------------------------------------------------------------------

# 履歴設定
set -gx fish_history_size 100000

# 自動補完の改善
set -g fish_autosuggestion_enabled 1
