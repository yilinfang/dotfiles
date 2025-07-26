-- lua/plugins/config/lazydev.lua
-- Configuration for lazydev.nvim

ok, lazydev = pcall(require, "lazydev")
if ok then
  lazydev.setup {
    library = {
      -- Load luvit types when the `vim.uv` word is found
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  }
else
  vim.notify("lazydev.nvim not found", vim.log.levels.WARN)
end
