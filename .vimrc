call pathogen#infect()
Helptags

syntax on
set autoindent
set autowrite
set expandtab
set hidden
set incsearch
set mouse=a
set number
set shiftwidth=4
set showcmd
set showmatch
set smartcase
set softtabstop=4
set tabstop=8
autocmd BufWritePre * :%s/\s\+$//e
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
filetype plugin indent on

map <C-H> <C-W>h<C-W>_
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>l<C-W>_

set colorcolumn=80
highlight ColorColumn ctermbg=blue
" set background=dark
set guifont=Inconsolata\ Medium\ 10
set guioptions=aegimt

set backspace=indent,eol,start

let g:vimfiler_as_default_explorer = 1
let g:vimfiler_ignore_pattern = ['pyc$', '^\.DS_Store$', '^__pycache__$', '^\.git$']

map <C-E> :VimFilerExplorer<CR>
