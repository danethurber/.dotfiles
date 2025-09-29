return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        file_ignore_patterns = {
          "%.env$",
          "%.env%..*$",
          "node_modules",
          "%.venv",
          "__pycache__",
          "%.git/",
          "%.nox",
          "%.aws%-sam",
        },
      },
    },
  },
}