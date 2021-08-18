local global = vim.g
local opt = vim.opt
local winopt = vim.wo

-- TODO: convert to lua
vim.cmd([[
syntax enable

colorscheme nord
set background=dark

set cmdheight=1
set cursorline
set guifont=Hack\ Nerd\ Font:h11
set laststatus=2  " Always display the status line
set lazyredraw
set showcmd       " display incomplete commands
set showmatch

set colorcolumn=+1

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·
]])

opt.termguicolors = true
opt.hidden = true

opt.splitbelow  = true
opt.splitright  = true

opt.ruler = true
opt.textwidth = 80

opt.numberwidth = 5
opt.relativenumber = true
winopt.number = true

global.nvim_tree_auto_close = 1
global.nvim_tree_ignore = {'.git', '.cache', 'node_modules'}
global.nvim_tree_quit_on_open = 1
global.nvim_tree_add_trailing = 1


-- TODO: convert to lua
vim.cmd([[
autocmd TermOpen * setlocal nonumber norelativenumber

let g:indent_blankline_filetype_exclude = ['dashboard', 'nvim-tree']
let g:indent_blankline_buftype_exclude = ['terminal']
]])
