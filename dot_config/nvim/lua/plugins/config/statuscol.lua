-- lua/plugins/config/statuscol.lua
-- Configuration of statuscol.nvim

local statuscol_ok, statuscol = pcall(require, "statuscol")
if statuscol_ok then
  local builtin = require "statuscol.builtin"
  local opts = {
    setopt = true,
    thousands = false,
    relculright = true,
    segments = {
      { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
      { -- Only show one sign with the highest priority
        text = { "%s", " " }, -- Add a space after the sign
        maxwidth = 1,
        colwidth = 1,
        click = "v:lua.ScSa",
      },
    },
  }
  statuscol.setup(opts)
else
  vim.notify("statuscol.nvim not found", vim.log.levels.WARN)
end
