" setting
syntax on
colorscheme molokai
set t_Co=256
set fenc=utf-8
set nobackup
set noswapfile
set autoread
set hidden
set showcmd

set number
set cursorline
set virtualedit=onemore
set smartindent
set visualbell
set showmatch
set laststatus=2
set wildmode=list:longest
set splitright

set expandtab
set tabstop=2
set shiftwidth=2
" Makefile
let _curfile=expand("%:r")
if _curfile == 'Makefile'
set noexpandtab
endif

set ignorecase
set incsearch
set wrapscan
set hlsearch
set splitright

nmap <Esc><Esc> :nohlsearch<CR><Esc>

nnoremap ; :
nnoremap : ;
nnoremap <Esc><Esc> :noh<CR>

nnoremap j gj
nnoremap k gk

augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
augroup END

call plug#begin()
Plug 'chriskempson/base16-vim'
call plug#end()

" base16
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
