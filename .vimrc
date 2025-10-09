syntax on
set number
set cursorline
set showcmd
set laststatus=2
set ruler
set showmode

" color
set t_Co=256
set fenc=utf-8
colorscheme molokai

" file operations
set nobackup
set noswapfile
set autoread
set hidden
set undofile
set undodir=~/.vim/undo

" editing
set virtualedit=onemore
set showmatch
set splitright
set wildmode=list:longest
set visualbell

" indentation
set expandtab
set tabstop=2
set shiftwidth=2
autocmd FileType make setlocal noexpandtab

" search
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch

" visible characters
set list
set listchars=tab:▸-,trail:·,extends:»,precedes:«

" keymap
nmap <Esc><Esc> :nohlsearch<CR><Esc>
nnoremap ; :
nnoremap : ;
nnoremap j gj
nnoremap k gk

" xml
augroup MyXML
  autocmd!
  autocmd Filetype xml,html inoremap <buffer> </ </<C-x><C-o>
augroup END

" plugin
call plug#begin()
Plug 'chriskempson/base16-vim'
Plug 'itchyny/lightline.vim'
call plug#end()

" base16
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

