" Search
set incsearch			" search as characters are entered
set hlsearch			" highlight matches
set wildmenu

let g:CommandTWildIgnore=&wildignore . ",*/node_modules"
let g:fzf_layout = { 'up': '~50%' }

nnoremap <Leader>t :Files<cr>
nnoremap <Leader>T :Rg<cr>
nnoremap <Leader>b :BLines<cr>
nnoremap <Leader>B :Buffers<cr>
nnoremap <Leader>P :Commands<cr>

nnoremap <Leader>/ :nohlsearch<CR>

