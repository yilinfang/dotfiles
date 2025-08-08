-- lua/plugins/mini/snippets.lua
-- Configuration for mini.snippets

local snippets_ok, snippets = pcall(require, "mini.snippets")
if snippets_ok then
  snippets.setup {
    snippets = {
      snippets.gen_loader.from_lang(), -- Load friendly-snippets
    },
  }
else
  vim.notify("mini.snippets not found", vim.log.levels.WARN)
end
