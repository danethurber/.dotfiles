local eslint = {
  lintCommand = 'eslint_d -f unix --stdin --stdin-filename ${INPUT}',
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = { '%f:%l:%c: %m' },
  formatCommand = 'eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}',
  formatStdin = true
}

local prettier = {
  formatCommand = 'prettier --stdin-filepath ${INPUT}',
  formatStdin = true
}

local prettier_options = {
  tabWidth = 2,
  useTabs = false,
  singleQuote = true,
  trailingComma = "all",
  configPrecedence = "prefer-file"
}

vim.g.format_options_javascript = prettier_options
vim.g.format_options_javascriptreact = prettier_options
vim.g.format_options_json = prettier_options
vim.g.format_options_markdown = prettier_options
vim.g.format_options_typescript = prettier_options
vim.g.format_options_typescriptreact = prettier_options
vim.g.format_options_yaml = prettier_options

return {
  javascript = { prettier, eslint },
  ["javascript.jsx"] = { prettier, eslint },
  javascriptreact = { prettier, eslint },
  json = { prettier },
  markdown = { prettier },
  typescript = { prettier, eslint },
  ["typescript.tsx"] = { prettier, eslint },
  typescriptreact = { prettier, eslint },
  yaml = { prettier },
}
