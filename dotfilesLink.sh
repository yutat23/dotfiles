#!/bin/bash
# =============================================================================
# dotfilesシンボリックリンク作成スクリプト
# =============================================================================

set -e  # エラーが発生したら終了

# カラー定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# スクリプトのディレクトリを取得
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_DIR="$HOME"

# ログ関数
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# プラットフォーム検出
detect_platform() {
    case "$(uname -s)" in
        Linux*)
            if grep -q Microsoft /proc/version 2>/dev/null; then
                echo "WSL"
            else
                echo "Linux"
            fi
            ;;
        Darwin*)
            echo "macOS"
            ;;
        MINGW*|MSYS*|CYGWIN*)
            echo "Windows"
            ;;
        *)
            echo "Unknown"
            ;;
    esac
}

PLATFORM=$(detect_platform)
log_info "Detected platform: $PLATFORM"

# シンボリックリンクを作成する関数
create_link() {
    local source="$1"
    local target="$2"
    local description="$3"
    
    # ソースファイルの存在確認
    if [ ! -e "$DOTFILES_DIR/$source" ]; then
        log_warning "Source file not found: $source (skipping)"
        return 2
    fi
    
    # ターゲットの親ディレクトリが存在するか確認
    local target_dir
    target_dir=$(dirname "$target")
    if [ ! -d "$target_dir" ]; then
        log_info "Creating directory: $target_dir"
        mkdir -p "$target_dir"
    fi
    
    # 既存のファイル/リンクの処理
    if [ -e "$target" ] || [ -L "$target" ]; then
        if [ -L "$target" ]; then
            # 既存のシンボリックリンクを確認
            local existing_target=$(readlink "$target")
            if [ "$existing_target" = "$DOTFILES_DIR/$source" ]; then
                log_info "Link already exists and points to correct location: $description"
                return 0
            else
                log_warning "Removing existing link: $target -> $existing_target"
                rm "$target"
            fi
        else
            # 既存のファイル/ディレクトリをバックアップ
            local backup="${target}.backup.$(date +%Y%m%d_%H%M%S)"
            log_warning "Backing up existing file: $target -> $backup"
            mv "$target" "$backup"
        fi
    fi
    
    # シンボリックリンクを作成
    if ln -sf "$DOTFILES_DIR/$source" "$target"; then
        log_success "Created link: $description"
        return 0
    else
        log_error "Failed to create link: $description"
        return 1
    fi
}

# 旧構成では ~/.config 全体をリポジトリへリンクしていたため、アプリの
# セッションやキャッシュまで作業ツリーへ書き込まれていた。既存データを
# 実ディレクトリへコピーしてから、管理対象だけを個別リンクへ切り替える。
prepare_config_directory() {
    local config_dir="$HOME_DIR/.config"
    local legacy_target="$DOTFILES_DIR/.config"
    local resolved_target=""

    if [ -L "$config_dir" ]; then
        resolved_target=$(cd "$config_dir" && pwd -P)
    fi

    if [ "$resolved_target" = "$legacy_target" ]; then
        log_info "Migrating legacy ~/.config symlink to a real directory..."
        rm "$config_dir"
        mkdir -p "$config_dir"

        if ! cp -a "$legacy_target/." "$config_dir/"; then
            log_error "Failed to preserve existing ~/.config data"
            return 1
        fi

        log_success "Preserved existing ~/.config data"
    elif [ ! -e "$config_dir" ]; then
        mkdir -p "$config_dir"
    fi
}

# メイン処理
main() {
    log_info "Starting dotfiles setup..."
    log_info "Dotfiles directory: $DOTFILES_DIR"
    log_info "Home directory: $HOME_DIR"
    echo ""
    
    # リンクを作成するファイルのリスト
    declare -a links=(
        ".bashrc:.bashrc:Bash configuration"
        ".zshrc:.zshrc:Zsh configuration"
        ".vimrc:.vimrc:Vim configuration"
        ".vim:.vim:Vim directory"
        ".gitconfig:.gitconfig:Git configuration"
        ".tmux.conf:.tmux.conf:tmux configuration"
    )
    
    # プラットフォーム固有のリンク
    if [ "$PLATFORM" = "WSL" ] || [ "$PLATFORM" = "Linux" ]; then
        # WSL/Linux用の追加設定があればここに追加
        :
    fi
    
    # 各リンクを作成
    local success_count=0
    local skip_count=0
    local error_count=0
    local result=0
    
    for link_spec in "${links[@]}"; do
        IFS=':' read -r source target description <<< "$link_spec"
        if create_link "$source" "$HOME_DIR/$target" "$description"; then
            success_count=$((success_count + 1))
        else
            result=$?
            if [ "$result" -eq 2 ]; then
                skip_count=$((skip_count + 1))
            else
                error_count=$((error_count + 1))
            fi
        fi
    done
    
    # ~/.config はアプリの生成データも置かれるため、管理対象だけをリンクする
    if [ -d "$DOTFILES_DIR/.config" ]; then
        prepare_config_directory

        declare -a config_links=(
            ".config/base16-shell:$HOME_DIR/.config/base16-shell:Base16 Shell configuration"
            ".config/fish/config.fish:$HOME_DIR/.config/fish/config.fish:Fish configuration"
            ".config/fish/fish_plugins:$HOME_DIR/.config/fish/fish_plugins:Fish plugin list"
            ".config/nvim:$HOME_DIR/.config/nvim:Neovim configuration"
            ".config/gh/config.yml:$HOME_DIR/.config/gh/config.yml:GitHub CLI configuration"
            ".config/herdr/config.toml:$HOME_DIR/.config/herdr/config.toml:Herdr configuration"
            ".config/zed/settings.json:$HOME_DIR/.config/zed/settings.json:Zed configuration"
        )

        for link_spec in "${config_links[@]}"; do
            IFS=':' read -r source target description <<< "$link_spec"
            if create_link "$source" "$target" "$description"; then
                success_count=$((success_count + 1))
            else
                result=$?
                if [ "$result" -eq 2 ]; then
                    skip_count=$((skip_count + 1))
                else
                    error_count=$((error_count + 1))
                fi
            fi
        done
    else
        log_warning ".config directory not found, skipping XDG configuration"
    fi
    
    # 結果を表示
    echo ""
    log_info "Setup completed!"
    log_success "Successfully linked: $success_count"
    if [ $skip_count -gt 0 ]; then
        log_warning "Skipped: $skip_count"
    fi
    if [ $error_count -gt 0 ]; then
        log_error "Errors: $error_count"
        exit 1
    fi
    
    log_info "Please restart your shell or run: source ~/.zshrc (or ~/.bashrc)"
}

# スクリプトを実行
main
