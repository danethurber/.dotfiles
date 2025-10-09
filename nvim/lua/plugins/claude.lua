return {
  {
    "coder/claudecode.nvim",
    opts = {
      terminal = {
        snacks_win_opts = {
          position = "bottom",
          height = 0.4,
          width = 1.0,
          border = "single",
        },
      },
    },
    keys = {
      -- Terminal mode window navigation
      { "<C-h>", "<cmd>wincmd h<cr>", mode = "t", desc = "Go to Left Window" },
      { "<C-j>", "<cmd>wincmd j<cr>", mode = "t", desc = "Go to Lower Window" },
      { "<C-k>", "<cmd>wincmd k<cr>", mode = "t", desc = "Go to Upper Window" },
      { "<C-l>", "<cmd>wincmd l<cr>", mode = "t", desc = "Go to Right Window" },
    },
  },
}