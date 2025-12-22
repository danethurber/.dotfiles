return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_format", "ruff_organize_imports" },
        typescript = { "prettier" },
        javascript = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        toml = { "taplo" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
}