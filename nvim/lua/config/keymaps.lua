-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Keymaps are automatically loaded on the VeryLazy event
--

vim.keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>", { silent = true })
vim.keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>", { silent = true })
vim.keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", { silent = true })
vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", { silent = true })

vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
vim.keymap.set("n", "Y", "yy", { desc = "Yank entire line (like yy)" })

-- Refactor Keymaps
vim.keymap.set("x", "<leader>re", function()
  require("refactoring").refactor("Extract Function")
end, { desc = "Extract Function" })

vim.keymap.set("x", "<leader>rf", function()
  require("refactoring").refactor("Extract Function To File")
end, { desc = "Extract Function To File" })
-- Extract function supports only visual mode
vim.keymap.set("x", "<leader>rv", function()
  require("refactoring").refactor("Extract Variable")
end, { desc = "Extract Variable" })
-- Extract variable supports only visual mode
vim.keymap.set("n", "<leader>rI", function()
  require("refactoring").refactor("Inline Function")
end, { desc = "Inline Function" })
-- Inline func supports only normal
vim.keymap.set({ "n", "x" }, "<leader>ri", function()
  require("refactoring").refactor("Inline Variable")
end, { desc = "Inline Variable" })
-- Inline var supports both normal and visual mode
vim.keymap.set("n", "<leader>rb", function()
  require("refactoring").refactor("Extract Block")
end, { desc = "Extract Block" })
vim.keymap.set("n", "<leader>rbf", function()
  require("refactoring").refactor("Extract Block To File")
end, { desc = "Extract Block To File" })
-- Extract block supports only normal mode
vim.keymap.set("n", "<leader>CC", "<cmd>ClaudeCode<CR>", { desc = "Toggle Claude Code" })
