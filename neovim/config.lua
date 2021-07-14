-- TODO: convert to lua
vim.cmd([[
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

set mouse=a
set encoding=utf-8

set nobackup
set nowritebackup
set directory=$HOME/.vim/swapfiles


" Default to not read-only in vimdiff
if &diff
  set noro
endif

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
]])


-- if &term =~ '256color'
--   " Disable Background Color Erase (BCE) so that color schemes
--   " work properly when Vim is used inside tmux and GNU screen.
--   set t_ut=
-- endif
