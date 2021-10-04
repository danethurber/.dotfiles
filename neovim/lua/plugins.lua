local present, _ = require('init-packer')
local packer

if present then
  packer = require "packer"
else
  error('Packer Not Found')
  return false
end

local use = packer.use

return packer.startup({ function()
  use { 'wbthomason/packer.nvim', event = 'VimEnter' }

  use 'tpope/vim-commentary'
  use 'tpope/vim-projectionist'
  use 'tpope/vim-surround'

  -- language related plugins
  use { "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    config = function()
      require "plugins.treesitter"
    end
  }

  use { "kabouzeid/nvim-lspinstall", event = "BufRead" }

  use { "neovim/nvim-lspconfig",
    after = "nvim-lspinstall",
    config = function()
      require "plugins.lspconfig.init"
    end
  }
  use { 'RishabhRD/nvim-lsputils',
    requires = { 'RishabhRD/popfix' },
    setup = function()
      require("plugins.others").lsputils()
    end
  }

  use { "onsails/lspkind-nvim",
    event = "BufRead",
    config = function()
      require("plugins.others").lspkind()
    end
  }

  use { 'glepnir/lspsaga.nvim',
    event = 'BufRead',
    config = function()
      require('lspsaga').init_lsp_saga {}
    end
  }

  use { "hrsh7th/nvim-compe",
    event = "InsertEnter",
    config = function()
      require "plugins.compe"
    end,
    wants = "LuaSnip",
    requires = {
      {
        "L3MON4D3/LuaSnip",
        wants = "friendly-snippets",
        event = "InsertCharPre",
        config = function()
          require "plugins.luasnip"
        end
      },
      {
        "rafamadriz/friendly-snippets",
        event = "InsertCharPre"
      }
    },
  }

  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("plugins.others").trouble()
    end
  }

  -- file manager, picker etc
  use { "kyazdani42/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    config = function()
      require "plugins.tree"
    end
  }

  use "kyazdani42/nvim-web-devicons"

  use { "nvim-telescope/telescope.nvim",
    requires = {{ 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' }},
    config = function()
      require "plugins.telescope"
    end
  }
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
  use "nvim-telescope/telescope-media-files.nvim"

  -- git related
  use { "lewis6991/gitsigns.nvim",
    after = "plenary.nvim",
    config = function()
      require "plugins.gitsigns"
    end
  }

  -- theme related
  use {
    'arcticicestudio/nord-vim',
    after = "packer.nvim",
    config = function()
      require "theme"
    end
  }
  use { "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    setup = function()
      require("plugins.others").blankline()
    end
  }

  use { 'nvim-lua/lsp-status.nvim',
    config = function()
      require("plugins.others").lspstatus()
    end
  }
  use { 'hoob3rt/lualine.nvim',
    requires = {
      { 'kyazdani42/nvim-web-devicons' },
      { 'nvim-lua/lsp-status.nvim' }
    },
    event = 'BufRead',
    config = function()
      require("plugins.others").lualine()
    end
  }
  use { "Pocco81/TrueZen.nvim",
    cmd = {
      "TZAtaraxis",
      "TZMinimalist",
      "TZFocus"
    },
    config = function()
      require "plugins.zenmode"
    end
  }
  use { "folke/twilight.nvim",
    cmd = {
      "Twilight",
      "TwilightEnable"
    },
    config = function()
      require("twilight").setup {}
    end
  }

  -- misc
  use { "glepnir/dashboard-nvim",
    event = "VimEnter",
    cmd = {
      "Dashboard",
      "DashboardNewFile",
      "DashboardJumpMarks",
      "SessionLoad",
      "SessionSave"
    },
    setup = function()
      require "plugins.dashboard"
    end
  }

  use { "windwp/nvim-autopairs",
    after = "nvim-compe",
    config = function()
      require "plugins.autopairs"
    end
  }
end })
