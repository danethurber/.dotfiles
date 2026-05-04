-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Terminal split positioning
vim.opt.splitbelow = true -- Open horizontal splits below
vim.opt.splitright = true -- Open vertical splits to the right

-- All-Astral Python toolchain (consumed by lazyvim.plugins.extras.lang.python)
-- ty: Astral's type checker LSP (beta). Install binary via: uv tool install ty
vim.g.lazyvim_python_lsp = "ty"
-- Use the native `ruff server` (built into the ruff binary), not the deprecated ruff-lsp
vim.g.lazyvim_python_ruff = "ruff"
