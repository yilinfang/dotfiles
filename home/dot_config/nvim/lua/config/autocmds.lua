-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Automatically enable wrap for quickfix window
vim.api.nvim_create_autocmd("FileType", {
  desc = "Enable wrap for quickfix window",
  group = vim.api.nvim_create_augroup("quickfix-wrap", { clear = true }),
  pattern = "qf",
  callback = function()
    vim.opt_local.wrap = true
  end,
})
