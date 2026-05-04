return {
  {
    "coder/claudecode.nvim",
    opts = {
      terminal = {
        -- Use native nvim terminal instead of snacks. Snacks provider has
        -- known cursor/character rendering bugs with Claude Code's TUI.
        provider = "native",
        split_side = "right",
        split_width_percentage = 0.40,
      },
    },
    keys = {
      -- ClaudeCode bindings (<leader>a = AI/agent)
      { "<leader>a", nil, desc = "AI/Claude" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue last Claude session" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer to Claude" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = { "v" }, desc = "Send selection to Claude" },
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept Claude diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny Claude diff" },

      -- Terminal mode window navigation
      { "<C-h>", "<cmd>wincmd h<cr>", mode = "t", desc = "Go to Left Window" },
      { "<C-j>", "<cmd>wincmd j<cr>", mode = "t", desc = "Go to Lower Window" },
      { "<C-k>", "<cmd>wincmd k<cr>", mode = "t", desc = "Go to Upper Window" },
      { "<C-l>", "<cmd>wincmd l<cr>", mode = "t", desc = "Go to Right Window" },
    },
  },
}