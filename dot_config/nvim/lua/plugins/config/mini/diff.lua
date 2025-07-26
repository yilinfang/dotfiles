-- lua/plugins/config/mini/diff.lua
-- Configuration for mini.diff

local diff_ok, diff = pcall(require, "mini.diff")
if diff_ok then
  diff.setup {
    view = {
      style = "sign",
      signs = {
        add = "┃",
        change = "┃",
        delete = "",
      },
    },
  }
else
  vim.notify("mini.diff not found", vim.log.levels.WARN)
end
