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
      -- Note: format-on-save is driven by LazyVim's autoformat
      -- (toggle with <leader>uf / <leader>uF). Setting format_on_save here
      -- would bypass that toggle.
    },
  },
}
