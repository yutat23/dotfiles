-- ~/.config/nvim/lua/config/init.lua

-- 基本設定
vim.opt.number = true          -- 行番号を表示
vim.opt.relativenumber = true  -- 相対行番号を表示
vim.opt.termguicolors = false

-- キーマップの例（最低限）
vim.g.mapleader = " "
-- USキー: Shiftなしでコマンドモードに入る（; → :）
--vim.keymap.set("n", ";", ":", { desc = "コマンドモード" })
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")

-- プラグインマネージャ lazy.nvim のセットアップ
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 残りの設定ファイルの読み込み
require("lazy").setup({
  { import = "config.keymaps" },  -- キーマップ設定
  { import = "config.indent" },    -- インデント設定
  { import = "plugins" },
  { import = "snippets.cpp" },  -- C++スニペット
})
