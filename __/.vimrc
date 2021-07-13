call plug#begin('~/.vim/plugged')
  Plug 'editorconfig/editorconfig-vim'

  Plug 'ps-dev/ps-time-vim'

  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'

  Plug 'voldikss/vim-floaterm'
  Plug 'wincent/terminus'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'RyanMillerC/better-vim-tmux-resizer'

  Plug 'tpope/vim-projectionist'
  Plug 'airblade/vim-gitgutter'
  Plug 'whiteinge/diffconflicts'

  Plug 'rakr/vim-one'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  Plug 'scrooloose/nerdtree'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'ryanoasis/vim-devicons'

  Plug 'sheerun/vim-polyglot'
  Plug 'moll/vim-node'
  Plug 'jparise/vim-graphql'
  Plug 'HerringtonDarkholme/yats'
  Plug 'jxnblk/vim-mdx-js'
  Plug 'ianks/vim-tsx'
  " Plug 'tmsvg/pear-tree'

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'https://github.com/alok/notational-fzf-vim'
  Plug 'vimwiki/vimwiki'
  " Plug 'rhysd/vim-grammarous'

  Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" NOTE: use `:PlugSnapshot plug.lock` to generator lock file

set encoding=utf-8

set nobackup
set nowritebackup
set directory=$HOME/.vim/swapfiles

if &term =~ '256color'
  " Disable Background Color Erase (BCE) so that color schemes
  " work properly when Vim is used inside tmux and GNU screen.
  set t_ut=
endif

" Default to not read-only in vimdiff
if &diff
  set noro
endif

source ~/.dotfiles/vim/coc.vim
source ~/.dotfiles/vim/keyboard.vim
source ~/.dotfiles/vim/window.vim
source ~/.dotfiles/vim/markdown.vim
source ~/.dotfiles/vim/terminal.vim
source ~/.dotfiles/vim/search.vim
source ~/.dotfiles/vim/wiki.vim

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

" commands to edit/source vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

