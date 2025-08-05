return {
  "coder/claudecode.nvim",
  dir = "~/Development/claudecode.nvim",

  opts = {
    log_level = "info",
    -- Terminal options
    terminal = {
      split_side = "right",
      split_width_percentage = 0.3,
      provider = "snacks", -- or "native"
    },

    --Diff options
    diff_opts = {
      auto_close_on_accept = true,
      vertical_split = true,
    },
  },
  config = true,
  keys = {
    { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
  },
}
