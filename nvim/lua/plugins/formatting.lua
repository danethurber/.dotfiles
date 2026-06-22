return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_format", "ruff_organize_imports" },
        toml = { "taplo" },
        -- Go (goimports+gofumpt) and every web filetype (ts/js/jsx/tsx/vue/json/
        -- yaml/css/html/markdown) come from LazyVim's lang.go and
        -- formatting.prettier extras — don't duplicate them here.
      },
      -- Note: format-on-save is driven by LazyVim's autoformat
      -- (toggle with <leader>uf / <leader>uF). Setting format_on_save here
      -- would bypass that toggle.
    },
  },
}
