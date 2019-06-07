set mouse=a

" Theme/Layout
syntax enable
colorscheme one
set background=dark
set cursorline
set guifont=Hack\ Nerd\ Font:h11
set laststatus=2  " Always display the status line
set lazyredraw
set number relativenumber
set numberwidth=5
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set showmatch
set termguicolors
set wildmenu

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

" autoreload file
set autoread                                                                                                                                                                                    
au CursorHold * checktime 

" Folding
set foldenable   
set foldlevelstart=10
set foldmethod=indent
set foldnestmax=10
" nnoremap <leader>z za " open/close folds

" Search
set incsearch			" search as characters are entered
set hlsearch			" highlight matches
let g:CommandTWildIgnore=&wildignore . ",*/node_modules"
nnoremap <leader>/ :nohlsearch<CR>	" turn off search highlight

" Nerdtree
let g:loaded_netrw=1 
let g:loaded_netrwPlugin=1
let g:NERDTreeLimitedSyntax = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeDirArrows = 1
let NERDTreeMinimalUI = 1
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
map <silent> <Leader>d :NERDTreeToggle<CR> " open
map <silent> <Leader>v :NERDTreeFind<CR> " open and find current file

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" airline
let g:airline_powerline_fonts = 1
let g:airline_section_z ="%3l/%L:%2v"
let g:airline_theme='one'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#bufferline#left_alt_sep = ""
let g:airline#extensions#bufferline#left_sep = ""
let g:airline#extensions#bufferline#right_alt_sep = ""
let g:airline#extensions#bufferline#right_sep = ""
