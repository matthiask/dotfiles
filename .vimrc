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
" Strip trailing whitespace before saving, always
autocmd BufWritePre * :%s/\s\+$//e
" Restore cursor position
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" ... except when entering git commit messages
autocmd BufReadPost COMMIT_EDITMSG exe "normal! gg"
filetype plugin indent on

set colorcolumn=80
highlight ColorColumn ctermbg=blue
" set background=dark
set guifont=Inconsolata\ Medium\ 10
set guioptions=aegimt

set backspace=indent,eol,start

let g:vimfiler_as_default_explorer = 1
let g:vimfiler_ignore_pattern = ['pyc$', '^\.DS_Store$', '^__pycache__$', '^\.git$', '\.sw.$', '^venv$', '^\.bundle$', '^\.tox$']

map <C-E> :VimFilerExplorer<CR>
