return {
  "okuuva/auto-save.nvim",
  keys = {
    { "<leader>at", "<cmd>ASToggle<CR>", desc = "Toggle Auto Save" },
  },
  opts = {
    enabled = true,
    condition = function(buf)
      local fn = vim.fn
      local utils = require("auto-save.utils.data")

      -- don't save for special-buffers
      if fn.getbufvar(buf, "&buftype") ~= "" then
        return false
      end
      -- don't save for `lua` file types yes!
      if utils.not_in(fn.getbufvar(buf, "&filetype"), { "lua" }) then
        return true
      end
      return false
    end,
  },
}
