local function autosave_status()
  local ok, autosave = pcall(require, "auto-save")
  if ok and autosave.is_enabled() then
    return "💾 AutoSave"
  else
    return "🛑 NoSave"
  end
end

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    table.insert(opts.sections.lualine_x, autosave_status)
  end,
  config = function()
    require("lualine").setup({
      options = {
        theme = "catppuccin",
      },
    })
  end,
}
