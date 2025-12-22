return {
  -- Multi-venv support for monorepo
  {
    "jglasovic/venv-lsp.nvim",
    config = function()
      require("venv-lsp").setup({
        search_venv_managers = true,
      })
    end,
  },

  -- Python LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                autoImportCompletions = true,
                autoImportFormat = "relative",
                typeCheckingMode = "basic",
              },
            },
          },
        },
        ruff = {}, -- Ruff for linting (10-100x faster than flake8)
      },
    },
  },

  -- Python DAP for debugging
  {
    "mfussenegger/nvim-dap-python",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dap-python").setup(vim.fn.exepath("python"))
    end,
  },
}