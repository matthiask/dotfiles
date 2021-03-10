" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'ctrlpvim/ctrlp.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'editorconfig/editorconfig-vim'
Plug 'herrbischoff/cobalt2.vim'
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }

call plug#end()

set termguicolors
set background=dark
" colorscheme cobalt2
colorscheme dracula

set directory=/dev/shm/
set backupcopy=yes " for webpack-dev-server
set mouse=a

set wildignore+=*/tmp/*,*.pyc,*.mo,*.whl
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
        \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif

" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
        \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

set autoindent
set autoread
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
set visualbell
" set wildmenu
" set wildmode=longest:full,full
set pastetoggle=<F2>
nnoremap <F3> :set hlsearch! hlsearch?<CR>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap Q <Nop>

nnoremap <F5> :mode<CR>
