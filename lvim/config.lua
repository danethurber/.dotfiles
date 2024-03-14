-- PLUGINS

lvim.plugins = {
  "stevearc/dressing.nvim",
  "gpanders/editorconfig.nvim",
  "rmehri01/onenord.nvim",
  "lvimuser/lsp-inlayhints.nvim",
  {
    "tpope/vim-surround",
    keys = { "c", "d", "y" }
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "antoinemadec/FixCursorHold.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter"
    }
  },

  -- javascript
  "nvim-neotest/neotest-jest",

  -- python
  "ChristianChiarulli/swenv.nvim",
  "mfussenegger/nvim-dap-python",
  "nvim-neotest/neotest-python",
}


-- GENERAL/INTERFACE

lvim.reload_config_on_save = true

vim.o.background = "dark"
lvim.colorscheme = "onenord"
lvim.transparent_window = false
lvim.log.level = "warn"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.breadcrumbs.active = true
lvim.builtin.illuminate.active = false
lvim.builtin.lualine.sections.lualine_a = { "mode" }

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


-- GENERAL KEYMAPPING

lvim.leader = "space"

local key_options = { noremap = true, silent = true }

local keymap = vim.keymap.set
keymap("n", "<C-Space>", "<cmd>WhichKey \\<space><cr>", key_options)

lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<C-d>"] = "<C-d>zz"
lvim.keys.normal_mode["<C-u>"] = "<C-u>zz"

lvim.keys.visual_mode["J"] = ":m '>+1<CR>gv=gv"
lvim.keys.visual_mode["K"] = ":m '<-2<CR>gv=gv"

keymap("n", "<m-h>", "<C-w>h", key_options)
keymap("n", "<m-j>", "<C-w>j", key_options)
keymap("n", "<m-k>", "<C-w>k", key_options)
keymap("n", "<m-l>", "<C-w>l", key_options)
keymap("n", "<m-tab>", "<c-6>", key_options)


-- TREE

lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.actions.open_file.quit_on_open = true

-- TERMINAL

lvim.builtin.terminal.active = true
lvim.builtin.terminal.open_mapping = "<C-t>"

lvim.builtin.which_key.mappings["t"] = {
  name = "+Terminal",
  f = { "<cmd>ToggleTerm<cr>", "Floating terminal" },
  v = { "<cmd>2ToggleTerm size=30 direction=vertical<cr>", "Split vertical" },
  h = { "<cmd>2ToggleTerm size=30 direction=horizontal<cr>", "Split horizontal" },
}


-- LANGUAGE SUPPORT

lvim.builtin.which_key.mappings["P"] = {
  name = "+Python",
  c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
}

-- FORMATTING

lvim.format_on_save.enabled = true

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { name = "black" },
  { command = "stylua" },
  {
    command = "prettier",
    extra_args = { "--print-width", "120" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "css" },
  },
}

-- LINTING
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    command = "eslint",
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  },
  { command = "flake8", filetypes = { "python" } }
}


-- TESTING

lvim.builtin.dap.active = true

local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
pcall(function()
  require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
end)

require("neotest").setup({
  adapters = {
    require('neotest-jest')({
      env = { CI = true },
      jestCommand = require('neotest-jest.jest-util').getJestCommand(vim.fn.expand '%:p:h')
    }),
    require('neotest-python')({
      dap = { justMyCode = false }
    })
  }
})

lvim.builtin.which_key.mappings["d"] = {
  name = "+Test/Debug",
  n = { "<cmd>lua require('neotest').run.run()<cr>", "Test Nearest" },

  -- m = { "<cmd>lua require('neotest').run.run()<cr>", "Test Method" },
  -- M = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Test Method (debug)" },
  -- f = { "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>", "Test Class" },
  -- F = { "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Test Class (debug)" },
  -- S = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Test Summary" },
}


-- TREESITTER

lvim.builtin.treesitter.auto_install = true
lvim.builtin.treesitter.autotag.enable = true
lvim.builtin.treesitter.highlight.enabled = true

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

-- WHICHKEY

local existingLspWhichKeys = lvim.builtin.which_key.mappings["l"]

table.insert(existingLspWhichKeys, {
  name = "Inlay Hints",
  h = { "<cmd>lua require('lsp-inlayhints').toggle()<cr>", "Toggle Hints" },
})

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


-- AUTO_COMMANDS

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd "set formatoptions-=cro"
  end,
})

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

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 40 }
  end,
})

-- vim.api.nvim_create_autocmd({ "VimEnter" }, {
--   callback = function()
--     vim.cmd "hi link illuminatedWord LspReferenceText"
--   end,
-- })

-- vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
--   pattern = { "*" },
--   callback = function()
--     vim.cmd "checktime"
--   end,
-- })
