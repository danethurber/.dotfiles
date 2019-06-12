call plug#begin('~/.vim/plugged')
	Plug 'editorconfig/editorconfig-vim'

	Plug 'rakr/vim-one'
	Plug 'ryanoasis/vim-devicons'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

  Plug 'whiteinge/diffconflicts'
  Plug 'tpope/vim-fugitive'

  Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
	Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
	Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'Lenovsky/nuake'
  Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'tpope/vim-projectionist'

	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-surround'
  Plug 'jiangmiao/auto-pairs'

	Plug 'sheerun/vim-polyglot'
	Plug 'moll/vim-node'
	Plug 'jparise/vim-graphql'
	" Plug 'ianks/vim-tsx'
	Plug 'Quramy/vim-js-pretty-template'
	Plug 'w0rp/ale'

	Plug 'janko/vim-test'
	Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

call plug#end()

set encoding=utf-8

set nobackup
set nowritebackup
set directory=$HOME/.vim/swapfiles

" Default to not read-only in vimdiff
if &diff
  set noro
endif

source ~/.dotfiles/vim/keyboard.vim
source ~/.dotfiles/vim/window.vim
source ~/.dotfiles/vim/language.vim
source ~/.dotfiles/vim/coc.vim

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

