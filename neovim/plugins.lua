local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])

vim.o.completeopt = "menuone,noselect"

vim.cmd([[
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
]])

return require('packer').startup({function()
  use 'wbthomason/packer.nvim'

  use 'neovim/nvim-lspconfig'
  use 'kabouzeid/nvim-lspinstall'

  use { 'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'nvim-treesitter/nvim-treesitter-textobjects'

  use { 'hrsh7th/nvim-compe',
    event = 'BufRead',
    config = function() require('compe').setup {
      enabled = true,
      autocomplete = true,
      documentation = true,
      source = {
        path = true;
        buffer = true;
        calc = true;
        nvim_lsp = true;
        nvim_lua = true;
        vsnip = true;
        ultisnips = true;
        luasnip = true;
      };
    }
  end }
  use 'sbdchd/neoformat'
  use 'glepnir/lspsaga.nvim'
  use { 'nvim-telescope/telescope.nvim',
    requires = {{ 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' }}
  }
  use { 'folke/trouble.nvim',
    requires = {{ 'kyazdani42/nvim-web-devicons' }},
    event = 'BufRead',
    config = function() require('trouble').setup {}
  end }

  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'

  use 'arcticicestudio/nord-vim'

  use 'voldikss/vim-floaterm'
  use 'christoomey/vim-tmux-navigator'
  use 'RyanMillerC/better-vim-tmux-resizer'

  use 'glepnir/dashboard-nvim'

  use { 'lukas-reineke/indent-blankline.nvim', event = 'BufRead' }
  use { 'beauwilliams/focus.nvim', event = 'BufRead' }

  use 'kyazdani42/nvim-tree.lua'
  use { 'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    event = 'BufRead',
    config = function() require('gitsigns').setup {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    }
  end }

  use { 'hoob3rt/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    event = 'BufRead',
    config = function() require('lualine').setup {
      options = { theme = 'nord' },
      sections = {
        lualine_x = { 'filetype' }
      }
    }
  end }

  use { "folke/which-key.nvim",
    config = function() require("which-key").setup {
      triggers = { "<leader>" }
    }
  end }

  use { 'folke/todo-comments.nvim',
    requires = { "nvim-lua/plenary.nvim" },
    event = 'BufRead',
    config = function() require('todo-comments').setup {}
  end }

end,
config = {
  display = {
    open_fn = require('packer.util').float,
  }
}})

