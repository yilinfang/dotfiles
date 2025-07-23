-- lua/plugins/mini/completion.lua
-- Configuration for mini.completion

local completion_ok, completion = pcall(require, "mini.completion")
if completion_ok then
  completion.setup {}
else
  vim.notify("mini.completion not found", vim.log.levels.WARN)
end
