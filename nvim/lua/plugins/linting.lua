return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        python = { "flake8" },
      },
    },
  },
  -- Disable ruff LSP (we're using flake8 for linting)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruff_lsp = false,
      },
    },
  },
}