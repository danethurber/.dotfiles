call plug#begin('~/.vim/plugged')
  Plug 'editorconfig/editorconfig-vim'

  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  Plug 'jiangmiao/auto-pairs'

  Plug 'wincent/terminus'
  Plug 'christoomey/vim-tmux-navigator'

  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'whiteinge/diffconflicts'

  Plug 'rakr/vim-one'
  Plug 'ryanoasis/vim-devicons'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'tpope/vim-projectionist'
  Plug 'https://github.com/alok/notational-fzf-vim'

  Plug 'sheerun/vim-polyglot'
  Plug 'moll/vim-node'
  Plug 'jparise/vim-graphql'
  Plug 'ianks/vim-tsx'
  Plug 'Quramy/vim-js-pretty-template'
  Plug 'w0rp/ale'

  Plug 'janko/vim-test'
  Plug 'machakann/vim-highlightedyank'
  Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
call plug#end()

" NOTE: use `:PlugSnapshot plug.lock` to generator lock file

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
source ~/.dotfiles/vim/markdown.vim
source ~/.dotfiles/vim/coc.vim
source ~/.dotfiles/vim/splash.vim

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

