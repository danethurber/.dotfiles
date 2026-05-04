return {
  -- In-editor uv commands (init, add, sync, run, lock).
  -- The Python LSP/ruff/dap/venv-selector wiring lives in
  -- lazyvim.plugins.extras.lang.python (see lazyvim.json).
  -- Toolchain selection is set via vim.g.lazyvim_python_* in config/options.lua.
  { "benomahony/uv.nvim" },

  -- Ensure debugpy is installed via Mason so nvim-dap-python (wired by the
  -- python extra) can find it without a manual :MasonInstall.
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "debugpy" } },
  },
}
