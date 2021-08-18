local opt = vim.opt

--don't write to the ShaDa file on startup
opt.shadafile = "NONE"

--set termguicolors
opt.termguicolors = true

opt.clipboard = "unnamedplus"
opt.cmdheight = 1
opt.completeopt = { "menuone", "noselect" }
opt.cul = true
opt.hidden = true
opt.ignorecase = true
opt.lazyredraw = true
opt.linebreak = true
opt.mouse = "a"
opt.ruler = true
opt.scrolloff = 3
opt.shell = "/bin/sh"
opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.textwidth = 80
opt.timeoutlen = 400
opt.undofile = true
opt.updatetime = 250 -- update interval for gitsigns
opt.wildmenu = true
opt.wildmode = 'longest:list:full'
opt.wrap = true

-- TODO: convert to lua
vim.cmd([[

set guifont=Hack\ Nerd\ Font:h11
set laststatus=2  " Always display the status line
set lazyredraw
set showcmd       " display incomplete commands
set showmatch

set colorcolumn=+1

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

]])

-- Line numbers
opt.number = true
opt.numberwidth = 5

-- for indentline
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2

-- shortmess options
opt.shortmess:append("casI") --disable intro

-- disable tilde on end of buffer:
vim.cmd("let &fcs='eob: '")

local disabled_built_ins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "matchit",
  "netrw",
  "netrwFileHandlers",
  "netrwPlugin",
  "netrwSettings",
  "rrhelper",
  "spellfile_plugin",
  "tar",
  "tarPlugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

--neovide
-- g.neovide_fullscreen = true
-- opt.guifont = "Liga SFMono Nerd Font Light:h14"
