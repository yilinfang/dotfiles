-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- LazyVim global options
vim.g.autoformat = true
vim.g.snacks_animate = false
vim.g.ai_cmp = false

-- Clipboard
if vim.env.SSH_TTY then
  vim.g.clipboard = {
    name = "Customized OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = function()
        local content = vim.fn.getreg("")
        return vim.split(content, "\n")
      end,
      ["*"] = function()
        local content = vim.fn.getreg("")
        return vim.split(content, "\n")
      end,
    },
  }
end

-- Indentation
vim.o.autoindent = true
vim.o.copyindent = true
vim.o.expandtab = false
vim.o.preserveindent = true
vim.o.shiftround = true
vim.o.shiftwidth = 8
vim.o.smartindent = true
vim.o.softtabstop = 8
vim.o.tabstop = 8
