set mouse=a

" Theme/Layout
syntax enable

colorscheme one

set background=dark
set cmdheight=1
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
highlight ColorColumn term=reverse ctermbg=1 guibg=#424242
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

" folding
" set foldenable
" set foldlevelstart=10
" set foldmethod=indent
" set foldnestmax=10
" nnoremap <leader>z za " open/close folds

" Explorer
let g:loaded_netrw=1
let g:loaded_netrwPlugin=1

let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeDirArrows = 1
let g:NERDTreeHighlightFolders = 1
let g:NERDTreeHighlightFoldersFullName = 1
let g:NERDTreeLimitedSyntax = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeShowHidden=1

let g:NERDTreeIgnore = ['.DS_Store', '^node_modules$']

" sync open file with NERDTree
" " Check if NERDTree is open or active
function! IsNERDTreeOpen()        
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufEnter * call SyncTree()

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

nnoremap <silent> <Leader>x :NERDTreeToggle<CR>
nnoremap <silent> <Leader>v :NERDTreeFind<CR>

let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_enable_startify = 1

let g:DevIconsEnableFolderExtensionPatternMatching = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:webdevicons_conceal_nerdtree_brackets = 1

" airline
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1

let g:airline_powerline_fonts = 1
let g:airline_theme='one'
let g:airline_skip_empty_sections = 1

call airline#parts#define('linenr', { 'accents': 'bold' })

autocmd User AirlineAfterInit call AirlineInit()
function! AirlineInit()
  let g:airline_section_z = airline#section#create(['hunks', 'linenr'])
endfunction

