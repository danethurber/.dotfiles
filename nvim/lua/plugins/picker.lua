-- snacks.picker is the LazyVim default picker (since 14.7).
-- Per-source `exclude` uses glob patterns (not lua patterns).
-- Note: snacks.picker uses fd/rg under the hood, which already respect
-- .gitignore — so node_modules / .venv / __pycache__ / .git are typically
-- excluded automatically. The patterns below cover dotfiles and
-- non-gitignored junk we still want hidden.
local exclude = {
  ".env",
  ".env.*",
  ".nox",
  ".aws-sam",
}

return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = { exclude = exclude },
          grep = { exclude = exclude },
          explorer = { exclude = exclude },
        },
      },
    },
  },
}
