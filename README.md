# dotfiles

個人用のdotfilesリポジトリです。複数プラットフォーム（Windows/WSL、Linux、macOS）に対応しています。

## 概要

このリポジトリには以下の設定ファイルが含まれています：

- **シェル設定**
  - `.zshrc` - zsh設定（推奨）
  - `.bashrc` - bash設定
  - `fish/config.fish` - fish設定

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
```

3. 新しいシェルセッションを開始するか、設定を再読み込み：
```bash
source ~/.zshrc
```

## プラットフォーム別の注意事項

### Windows + WSL

- WSL環境で使用する場合、`local.sh`のDISPLAY設定が自動的に適用されます
- `mybin/expl`スクリプトを使用してWSLからWindowsエクスプローラーを開くことができます

### Linux

- ほとんどの設定がそのまま動作します
- 必要に応じてパッケージマネージャーで必要なツールをインストールしてください

### macOS

- Homebrewを使用して必要なツールをインストールすることを推奨します
- `exa`や`bat`などのモダンなツールのエイリアスが設定されています

## カスタマイズ

### シェル設定のカスタマイズ

各シェルの設定ファイルを編集して、お好みの設定を追加できます。

- zsh: `~/.zshrc`を編集
- bash: `~/.bashrc`を編集
- fish: `fish/config.fish`を編集

### Vim設定のカスタマイズ

- `~/.vimrc`を編集してVimの設定を変更
- プラグインは`~/.vim/`ディレクトリにインストールされます

### プラグインのインストール

Vimプラグインは`vim-plug`を使用して管理されています。プラグインをインストールするには：

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
├── fish/
│   └── config.fish      # fish設定
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

## トラブルシューティング

### シンボリックリンクが作成されない

- 既存のファイルがある場合は、バックアップを取ってから削除してください
- スクリプトに実行権限があることを確認してください：`chmod +x dotfilesLink.sh`

### プラグインが読み込まれない

- Vimプラグインをインストール：`vim +PlugInstall +qall`
- `~/.vim/autoload/plug.vim`が存在することを確認

### カラースキームが適用されない

- Base16シェルがインストールされていることを確認
- `~/.config/base16-shell/`が存在することを確認

## ライセンス

このリポジトリは個人用です。自由にフォークしてカスタマイズしてください。

## 更新履歴

- 2026-02-04: ドキュメント追加と設定ファイルの整理
