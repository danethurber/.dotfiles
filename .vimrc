" TODO:
"   - autocomplete (coc.vim)
"   - testing/projectionist

call plug#begin('~/.vim/plugged')
	Plug 'editorconfig/editorconfig-vim'

	Plug 'rakr/vim-one'
	Plug 'bling/vim-bufferline'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'ryanoasis/vim-devicons'

	Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
	Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
	Plug 'Xuyuanp/nerdtree-git-plugin'
	Plug 'wincent/command-t', {
		\  'do': 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make' }

	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-surround'

	Plug 'sheerun/vim-polyglot'
	Plug 'ianks/vim-tsx'
	Plug 'moll/vim-node'
	Plug 'jason0x43/vim-js-indent'
	Plug 'Quramy/vim-js-pretty-template'
	Plug 'janko/vim-test'
  Plug 'mattn/emmet-vim'
	Plug 'jparise/vim-graphql'
	Plug 'w0rp/ale'	
	Plug 'Quramy/tsuquyomi'

	Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

call plug#end()	

set encoding=utf-8

set nobackup
set nowritebackup
set directory=$HOME/.vim/swapfiles

source ~/.dotfiles/vim/keyboard.vim
source ~/.dotfiles/vim/window.vim
source ~/.dotfiles/vim/language.vim

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
