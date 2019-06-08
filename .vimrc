" TODO:
"   - testing/projectionist

call plug#begin('~/.vim/plugged')
	Plug 'editorconfig/editorconfig-vim'

	Plug 'rakr/vim-one'
	Plug 'ryanoasis/vim-devicons'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
  Plug 'tpope/vim-vinegar'
  Plug 'tpope/vim-fugitive'

	Plug 'wincent/command-t', {
		\  'do': 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make' }
  Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}

	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-surround'
  Plug 'jiangmiao/auto-pairs'

	Plug 'sheerun/vim-polyglot'
	Plug 'moll/vim-node'
	Plug 'jparise/vim-graphql'
	Plug 'Quramy/vim-js-pretty-template'
	Plug 'w0rp/ale'

	" Plug 'ianks/vim-tsx'

	Plug 'janko/vim-test'
	Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

call plug#end()

set encoding=utf-8

set nobackup
set nowritebackup
set directory=$HOME/.vim/swapfiles

source ~/.dotfiles/vim/keyboard.vim
source ~/.dotfiles/vim/window.vim
source ~/.dotfiles/vim/language.vim
source ~/.dotfiles/vim/coc.vim

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
