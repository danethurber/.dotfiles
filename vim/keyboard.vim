set clipboard=unnamed
set backspace=2   " Backspace deletes like most programs in insert mode
set history=50
filetype indent on

set nowrap
set linebreak

set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" leader
let mapleader = "\<Space>"

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" Preserve indentation when moving lines
" See http://vim.wikia.com/wiki/Moving_lines_up_or_down
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Switch between the last two files
nnoremap <Leader><Leader> <C-^>

" Hard-ish Mode
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Test shortcuts
let g:test#no_alternate = 2 " projectionist

" Run commands that require an interactive shell
nnoremap <Leader>r :RunInInteractiveShell<Space>

" I removed multiple-cursors. use native vim instead
" https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db
nnoremap <C-n> :echoe "use cgn instead of multiple cursors"<CR>

