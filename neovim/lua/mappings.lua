local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local cmd = vim.cmd
local opt = {}

vim.g.mapleader = " "

map("n", "<leader>ev", ":vsplit $MYVIMRC<CR><CR>", opt) -- Open Vim Config
map("n", "<leader>sv", ":source $MYVIMRC<CR><CR>", opt) -- Reload Vim Config

map("", "<leader><leader>", "<C-^>", opt)

map("", "j", 'v:count ? "j" : "gj"', { expr = true })
map("", "k", 'v:count ? "k" : "gk"', { expr = true })
map("", "<Down>", 'v:count ? "j" : "gj"', { expr = true })
map("", "<Up>", 'v:count ? "k" : "gk"', { expr = true })

map('n', '<c-k>', [[<Cmd>wincmd k<CR>]], opt)
map('n', '<c-j>', [[<Cmd>wincmd j<CR>]], opt)
map('n', '<c-h>', [[<Cmd>wincmd h<CR>]], opt)
map('n', '<c-l>', [[<Cmd>wincmd l<CR>]], opt)

-- remove trailing whitespaces
cmd([[autocmd BufWritePre * %s/\s\+$//e]])
cmd([[autocmd BufWritePre * %s/\n\+\%$//e]])

-- NvimTree
map("n", "<leader>x", ":NvimTreeToggle<CR>", opt)

-- compe stuff
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col(".") - 1
  if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
    return true
  else
    return false
  end
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn["compe#complete"]()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

function _G.completions()
  local npairs
  if
    not pcall(
      function()
        npairs = require "nvim-autopairs"
      end
    )
  then
    return
  end

  if vim.fn.pumvisible() == 1 then
    if vim.fn.complete_info()["selected"] ~= -1 then
      return vim.fn["compe#confirm"]("<CR>")
    end
  end
  return npairs.check_break_line_char()
end

-- compe mappings
map("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
map("s", "<Tab>", "v:lua.tab_complete()", { expr = true })
map("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
map("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
map("i", "<CR>", "v:lua.completions()", { expr = true })

-- Telescope
map("n", "<leader>ff", '<cmd>Telescope find_files<CR>', opt)
map("n", "<leader>fl", '<cmd>Telescope live_grep<CR>', opt)
map("n", "<leader>fg", '<cmd>Telescope oldfiles<CR>', opt)
map("n", "<leader>fb", '<cmd>Telescope buffers<CR>', opt)
map("n", "<leader>fc", '<cmd>Telescope commands<CR>', opt)
map("n", "<leader>fh", '<cmd>Telescope oldfiles<CR>', opt)
map("n", "<leader>fe", '<cmd>Telescope file_browser<CR>', opt)

-- Search
map("n", "<Leader>/", '<cmd>:nohlsearch<CR>', opt)

-- Packer commands till because we are not loading it at startup
cmd("silent! command PackerCompile lua require 'plugins' require('packer').compile()")
cmd("silent! command PackerInstall lua require 'plugins' require('packer').install()")
cmd("silent! command PackerStatus lua require 'plugins' require('packer').status()")
cmd("silent! command PackerSync lua require 'plugins' require('packer').sync()")
cmd("silent! command PackerUpdate lua require 'plugins' require('packer').update()")
