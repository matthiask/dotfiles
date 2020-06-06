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
set smartcase
set softtabstop=4
set tabstop=8
set colorcolumn=80
highlight ColorColumn ctermbg=lightgray
set backspace=indent,eol,start
set encoding=utf-8
set scrolloff=3  " context lines above and below cursor
set noerrorbells
" set wildmenu
" set wildmode=longest:full,full
set pastetoggle=<F2>

nnoremap <F3> :set hlsearch! hlsearch?<CR>

" Strip trailing whitespace before saving, always
autocmd BufWritePre * :%s/\s\+$//e

" Restore cursor position
" Thanks, http://stackoverflow.com/a/4348480/317346
function! PositionCursorFromViminfo()
  if !(bufname("%") =~ '\(COMMIT_EDITMSG\)') && line("'\"") > 1 && line("'\"") <= line("$")
    exe "normal! g`\""
  endif
endfunction
autocmd BufReadPost * call PositionCursorFromViminfo()

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

filetype plugin indent on

let g:vimfiler_as_default_explorer = 1
let g:vimfiler_ignore_pattern = ['pyc$', '^\.DS_Store$', '^__pycache__$', '^\.git$', '\.sw.$', '^\.bundle$', '^\.tox$', '^\.$', '^\.\.$']

map <C-E> :VimFilerExplorer<CR>

" No training wheels
" nnoremap <up> <nop>
" nnoremap <down> <nop>
" nnoremap <left> <nop>
" nnoremap <right> <nop>
" inoremap <up> <nop>
" inoremap <down> <nop>
" inoremap <left> <nop>
" inoremap <right> <nop>

if has("unix")
  if has("mac") || has("macunix")
    set directory=/tmp/
    " set backupcopy=yes  " for react-native?
  else
    set directory=/dev/shm/
    set backupcopy=yes  " for webpack-dev-server
  endif
endif

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap Q <Nop>

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

set background=light
let g:wwdc17_term_italics = 0
let g:wwdc17_transp_bg = 1
let g:wwdc17_frame_color = 12
colorscheme wwdc17

" set background=dark
" colorscheme cobalt2

set wildignore+=*/tmp/*,*/node_modules/*,*.pyc,*/venv/*
