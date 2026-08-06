# dotfiles

## 概要


- **シェル設定**
  - `.zshrc` - zsh設定（推奨）
  - `.bashrc` - bash設定
  - `.config/fish/config.fish` - fish設定

- **エディタ設定**
  - `.vimrc` - Vim設定
  - `.vim/` - Vimプラグインとカラースキーム

- **その他**
  - `.tmux.conf` - tmux設定
  - `.gitconfig` - Git設定
  - `dotfilesLink.sh` - シンボリックリンク作成スクリプト

## セットアップ

### 前提条件

- Git
- zsh（推奨）またはbash
- Vim
- tmux（オプション）

### インストール手順

1. リポジトリをクローン：
```bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

2. シンボリックリンクを作成：
```bash
chmod +x dotfilesLink.sh
./dotfilesLink.sh
```

または手動でリンクを作成：
```bash
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.vim ~/.vim
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
mkdir -p ~/.config/fish ~/.config/gh ~/.config/herdr ~/.config/zed
ln -sf ~/dotfiles/.config/fish/config.fish ~/.config/fish/config.fish
ln -sf ~/dotfiles/.config/fish/fish_plugins ~/.config/fish/fish_plugins
ln -sfn ~/dotfiles/.config/nvim ~/.config/nvim
```

`~/.config` 全体はリンクしない。アプリのセッション、キャッシュ、端末固有情報が
リポジトリへ混入しないよう、管理対象の設定だけを個別にリンク。

3. 新しいシェルセッションを開始するか、設定を再読み込み：
```bash
source ~/.zshrc
```

```bash
vim +PlugInstall +qall
```

## ファイル構成

```
dotfiles/
├── .bashrc              # bash設定
├── .zshrc               # zsh設定（推奨）
├── .vimrc               # Vim設定
├── .vim/                # Vimプラグインとカラースキーム
├── .tmux.conf           # tmux設定
├── .gitconfig           # Git設定
├── .gitignore           # Git除外設定
├── dotfilesLink.sh      # セットアップスクリプト
├── .config/
│   ├── fish/            # fish設定とプラグイン一覧
│   ├── nvim/            # Neovim設定
│   ├── gh/              # GitHub CLI設定
│   ├── herdr/           # Herdr設定
│   └── zed/             # Zed設定
├── mybin/               # カスタムスクリプト
│   └── expl            # WSL用エクスプローラー起動スクリプト
└── README.md            # このファイル
```

## 主要な機能

### zsh設定

- 履歴管理（100,000件）
- 自動補完
- カラー表示
- 便利なエイリアス
- tmux自動起動（オプション）
- Base16カラースキーム（Monokai）

### Vim設定

- シンタックスハイライト
- 行番号表示
- インデント設定（2スペース）
- 検索設定（大文字小文字を区別しない）
- vim-plugによるプラグイン管理

### tmux設定

- プレフィックスキー: `C-q`
- Vim風キーバインド
- 256色対応
- マウス操作有効
- カスタムステータスライン

### Git設定

- 便利なエイリアス（`st`, `df`, `co`, `br`, `ps`, `pl`, `ck`, `sw`）
- カスタムログフォーマット（`plog`）
- 認証情報キャッシュ