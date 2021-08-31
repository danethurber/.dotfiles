local configs = {}

configs.blankline = function()
  vim.g.indentLine_enabled = 1
  vim.g.indent_blankline_char = "▏"

  vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard" }
  vim.g.indent_blankline_buftype_exclude = { "terminal" }

  vim.g.indent_blankline_show_trailing_blankline_indent = false
  vim.g.indent_blankline_show_first_indent_level = false
end

configs.lspkind = function()
  local present, lspkind = pcall(require, "lspkind")

  if present then
    lspkind.init()
  end
end

configs.neoformat = function()
  vim.cmd([[
    augroup fmt
      autocmd!
      autocmd BufWritePre * undojoin | Neoformat
    augroup END
  ]])
end

configs.lualine = function()
  local present, lspkind = pcall(require, "lualine")

  if present then
    lspkind.setup {
      options = { theme = 'nord' },
      sections = {
        lualine_x = { 'filetype' }
      }
    }
  end
end

configs.trouble = function()
  local present, trouble = pcall(require, "trouble")

  if present then
    trouble.setup()
  end
end

return configs
