-- PLUGINS
lvim.plugins = {
  "gpanders/editorconfig.nvim",
  "rmehri01/onenord.nvim",
  "lvimuser/lsp-inlayhints.nvim",
  {
    "tpope/vim-surround",
    keys = { "c", "d", "y" }
  }
}

-- OPTIONS

lvim.colorscheme = "onenord"
lvim.log.level = "warn"
vim.o.background = "dark"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.breadcrumbs.active = true
lvim.builtin.dap.active = true
lvim.builtin.illuminate.active = false
lvim.builtin.lualine.sections.lualine_a = { "mode" }

lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.actions.open_file.quit_on_open = true

lvim.builtin.terminal.active = true
lvim.builtin.terminal.open_mapping = "<C-t>"

lvim.builtin.treesitter.auto_install = true
lvim.builtin.treesitter.highlight.enabled = true

lvim.reload_config_on_save = true
lvim.transparent_window = false

lvim.format_on_save.enabled = true

local options = {
  backup = false, -- creates a backup file
  clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  cmdheight = 1, -- more space in the neovim command line for displaying messages
  colorcolumn = "120",
  conceallevel = 0, -- so that `` is visible in markdown files
  cursorline = true, -- highlight the current line
  expandtab = true, -- convert tabs to spaces
  fileencoding = "utf-8", -- the encoding written to a file
  -- guifont = "monospace:h17", -- the font used in graphical neovim applications
  hlsearch = true, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  incsearch = true, -- make search act like search in modern browsers
  laststatus = 3,
  mouse = "a", -- allow the mouse to be used in neovim
  number = true, -- set numbered lines
  numberwidth = 4, -- set number column width to 2 {default 4}
  pumheight = 10, -- pop up menu height
  relativenumber = false, -- set relative numbered lines
  ruler = false,
  scrolloff = 8,
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  showcmd = false,
  showmode = false, -- we don't need to see things like -- INSERT -- anymore
  showtabline = 0, -- always show tabs
  sidescrolloff = 8,
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  smartcase = true, -- smart case
  smartindent = true, -- make indenting smarter again
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  tabstop = 2, -- insert 2 spaces for a tab
  termguicolors = true, -- set term gui colors (most terminals support this)
  timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
  title = true,
  undofile = true, -- enable persistent undo
  updatetime = 100, -- faster completion (4000ms default)
  wrap = false, -- display lines as one long line
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"

-- KEYMAPS

lvim.leader = "space"

local opts = { noremap = true, silent = true }

local keymap = vim.keymap.set
keymap("n", "<C-Space>", "<cmd>WhichKey \\<space><cr>", opts)

lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<C-d>"] = "<C-d>zz"
lvim.keys.normal_mode["<C-u>"] = "<C-u>zz"
lvim.keys.visual_mode["J"] = ":m '>+1<CR>gv=gv"
lvim.keys.visual_mode["K"] = ":m '<-2<CR>gv=gv"
lvim.keys.normal_mode["<leader><leader>"] = ":Telescope buffers<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

lvim.keys.normal_mode["<leader>t"] = "<cmd>TroubleToggle<CR>"
lvim.keys.normal_mode["<leader>o"] = "<cmd>SymbolsOutline<CR>"

-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Terminal",
--   f = { "<cmd>ToggleTerm<cr>", "Floating terminal" },
--   v = { "<cmd>2ToggleTerm size=30 direction=vertical<cr>", "Split vertical" },
--   h = { "<cmd>2ToggleTerm size=30 direction=horizontal<cr>", "Split horizontal" },
-- }

keymap("n", "<m-h>", "<C-w>h", opts)
keymap("n", "<m-j>", "<C-w>j", opts)
keymap("n", "<m-k>", "<C-w>k", opts)
keymap("n", "<m-l>", "<C-w>l", opts)
keymap("n", "<m-tab>", "<c-6>", opts)

-- Resize with arrows
-- keymap("n", "<C-Up>", ":resize -2<CR>", opts)
-- keymap("n", "<C-Down>", ":resize +2<CR>", opts)
-- keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
-- keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts

-- AUTO_COMMANDS
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd "set formatoptions-=cro"
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "Jaq" },
  callback = function()
    vim.cmd [[
        nnoremap <silent> <buffer> <m-r> :close<CR>
        " nnoremap <silent> <buffer> <m-r> <NOP>
        set nobuflisted
      ]]
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "" },
  callback = function()
    local buf_ft = vim.bo.filetype
    if buf_ft == "" or buf_ft == nil then
      vim.cmd [[
        nnoremap <silent> <buffer> q :close<CR>
        " nnoremap <silent> <buffer> <c-j> j<CR>
        " nnoremap <silent> <buffer> <c-k> k<CR>
        set nobuflisted
      ]]
    end
  end,
})

-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
--   pattern = { "" },
--   callback = function()
--     local get_project_dir = function()
--       local cwd = vim.fn.getcwd()
--       local project_dir = vim.split(cwd, "/")
--       local project_name = project_dir[#project_dir]
--       return project_name
--     end

--     vim.opt.titlestring = get_project_dir() .. " - nvim"
--   end,
-- })

-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
--   pattern = { "term://*" },
--   callback = function()
--     vim.cmd "startinsert!"
--     vim.cmd "set cmdheight=1"
--   end,
-- })

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
  callback = function()
    vim.cmd "quit"
  end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd "set formatoptions-=cro"
  end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 40 }
  end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.cmd "hi link illuminatedWord LspReferenceText"
  end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  pattern = { "*" },
  callback = function()
    vim.cmd "checktime"
  end,
})

-- LSP

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "stylua" },
  {
    command = "prettier",
    -- extra_args = { "--print-width", "120" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "css" },
  },
}
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    command = "eslint",
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  },
}


-- TREESITTER

lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "css",
  "javascript",
  "json",
  "lua",
  "python",
  "tsx",
  "typescript",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell", "markdown" }
lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.treesitter.autotag.enable = true
lvim.builtin.treesitter.auto_install = true

lvim.builtin.treesitter.textobjects = {
  select = {
    enable = true,
    -- Automatically jump forward to textobj, similar to targets.vim
    lookahead = true,
    keymaps = {
      -- You can use the capture groups defined in textobjects.scm
      ["af"] = "@function.outer", -- select the outer function
      ["if"] = "@function.inner", -- select the inner function
      ["at"] = "@class.outer", -- select the outer class
      ["it"] = "@class.inner", -- select the inner class
      ["ac"] = "@call.outer", -- select the outer call
      ["ic"] = "@call.inner", -- select the inner call
      ["aa"] = "@parameter.outer", -- select the outer parameter
      ["ia"] = "@parameter.inner", -- select the inner parameter
      ["al"] = "@loop.outer",
      ["il"] = "@loop.inner",
      ["ai"] = "@conditional.outer",
      ["ii"] = "@conditional.inner",
      ["a/"] = "@comment.outer",
      ["i/"] = "@comment.inner",
      ["ab"] = "@block.outer",
      ["ib"] = "@block.inner",
      ["as"] = "@statement.outer",
      ["is"] = "@scopename.inner",
      ["aA"] = "@attribute.outer",
      ["iA"] = "@attribute.inner",
      ["aF"] = "@frame.outer",
      ["iF"] = "@frame.inner",
    },
  },
}

-- TELESCOPE

lvim.builtin.telescope.defaults.file_ignore_patterns = {
  ".git/",
  "target/",
  "docs/",
  "vendor/*",
  "%.lock",
  "__pycache__/*",
  "%.sqlite3",
  "%.ipynb",
  "node_modules/*",
  -- "%.jpg",
  -- "%.jpeg",
  -- "%.png",
  "%.svg",
  "%.otf",
  "%.ttf",
  "%.webp",
  ".dart_tool/",
  ".github/",
  ".gradle/",
  ".idea/",
  ".settings/",
  ".vscode/",
  "__pycache__/",
  "build/",
  "env/",
  "gradle/",
  "node_modules/",
  "%.pdb",
  "%.dll",
  "%.class",
  "%.exe",
  "%.cache",
  "%.ico",
  "%.pdf",
  "%.dylib",
  "%.jar",
  "%.docx",
  "%.met",
  "smalljre_*/*",
  ".vale/",
  "%.burp",
  "%.mp4",
  "%.mkv",
  "%.rar",
  "%.zip",
  "%.7z",
  "%.tar",
  "%.bz2",
  "%.epub",
  "%.flac",
  "%.tar.gz",
}

-- WHICHKEY

local existingLspWhichKeys = lvim.builtin.which_key.mappings["l"]

table.insert(existingLspWhichKeys, {
  name = "Inlay Hints",
  h = { "<cmd>lua require('lsp-inlayhints').toggle()<cr>", "Toggle Hints" },
})
