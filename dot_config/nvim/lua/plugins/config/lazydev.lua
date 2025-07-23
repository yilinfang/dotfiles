-- lua/plugins/config/lazydev.lua
-- Configuration for lazydev.nvim

-- Create a autocmd to load lazydev.nvim when editing Lua files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  desc = "Load lazydev.nvim for Lua files",
  group = vim.api.nvim_create_augroup("lazydev-lua", { clear = true }),
  once = true, -- Load only once for the first Lua file opened
  callback = function()
    vim.cmd "packadd! lazydev.nvim"
    local lazydev_ok, lazydev = pcall(require, "lazydev")
    if lazydev_ok then
      lazydev.setup {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      }
    else
      vim.notify("lazydev.nvim not found", vim.log.levels.WARN)
    end
  end,
})
