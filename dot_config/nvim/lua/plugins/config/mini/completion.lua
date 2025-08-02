-- lua/plugins/mini/completion.lua
-- Configuration for mini.completion

local completion_ok, completion = pcall(require, "mini.completion")
if completion_ok then
  local opts = {
    fallbak_action = "<C-p>", -- HACK: Replace builtin <C-p> completion
    mappings = {
      force_twostep = "<C-n>", -- HACK: Replace builtin <C-n> completion
      force_fallback = "",
    },
  }
  completion.setup(opts)
else
  vim.notify("mini.completion not found", vim.log.levels.WARN)
end
