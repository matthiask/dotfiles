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
highlight ColorColumn ctermbg=gray
set backspace=indent,eol,start
set encoding=utf-8

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

filetype plugin indent on

" set background=dark

let g:vimfiler_as_default_explorer = 1
let g:vimfiler_ignore_pattern = ['pyc$', '^\.DS_Store$', '^__pycache__$', '^\.git$', '\.sw.$', '^venv$', '^\.bundle$', '^\.tox$']

map <C-E> :VimFilerExplorer<CR>

" No training wheels
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
