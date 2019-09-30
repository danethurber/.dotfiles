call plug#begin('~/.vim/plugged')
  Plug 'editorconfig/editorconfig-vim'

  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'

  Plug 'wincent/terminus'
  Plug 'christoomey/vim-tmux-navigator'

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

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'https://github.com/alok/notational-fzf-vim'

  Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
  Plug 'iamcco/coc-svg', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-git', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-pairs', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-tslint-plugin', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-yank', {'do': 'yarn install --frozen-lockfile'}
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

source ~/.dotfiles/vim/keyboard.vim
source ~/.dotfiles/vim/window.vim
source ~/.dotfiles/vim/language.vim
source ~/.dotfiles/vim/markdown.vim
source ~/.dotfiles/vim/search.vim

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

" commands to edit/source vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

