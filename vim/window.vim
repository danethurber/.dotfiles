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

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" autoreload file
set autoread
au CursorHold * checktime

" Folding
" set foldenable
" set foldlevelstart=10
" set foldmethod=indent
" set foldnestmax=10
" nnoremap <leader>z za " open/close folds

" Search
set incsearch			" search as characters are entered
set hlsearch			" highlight matches
set wildmenu

let g:CommandTWildIgnore=&wildignore . ",*/node_modules"

nnoremap <silent> <Leader>t :Files<CR>
nnoremap <leader>/ :nohlsearch<CR>    " turn off search highlight

" Explorer
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

map <silent> <Leader>d :Vexplore<CR>

" terminal
nnoremap <leader>1 :Nuake<CR>
inoremap <leader>1 <C-\><C-n>:Nuake<CR>
tnoremap <leader>1 <C-\><C-n>:Nuake<CR>

" airline
let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_section_z ="%3l/%L:%2v"
let g:airline_theme='one'

