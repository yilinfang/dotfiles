-- lua/config/options.lua

-- [[ Global options ]]
vim.g.mapleader = " "
vim.g.maplocalleader = " "
if vim.env.SSH_TTY then
  vim.g.clipboard = {
    name = "Customized OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy "+",
      ["*"] = require("vim.ui.clipboard.osc52").copy "*",
    },
    paste = {
      ["+"] = function()
        local content = vim.fn.getreg ""
        return vim.split(content, "\n")
      end,
      ["*"] = function()
        local content = vim.fn.getreg ""
        return vim.split(content, "\n")
      end,
    },
  }
end

-- [[ Neovim options ]]
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = "yes:1" -- Only show sign with highest priority
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.o.inccommand = "split"
vim.o.cursorline = true
vim.o.scrolloff = 8
vim.o.confirm = true
vim.o.wrap = false
vim.o.linebreak = true
vim.o.showmode = false
vim.o.mouse = "a"
vim.o.number = true
vim.o.relativenumber = false
vim.opt.fillchars = { eob = " " }
vim.o.autoread = true
vim.o.completeopt = "menuone,noselect,fuzzy"
vim.o.shiftround = true
vim.o.shiftwidth = 8
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.softtabstop = 8
vim.o.tabstop = 8
vim.o.autoindent = true
vim.o.breakindent = true
vim.o.copyindent = true
vim.o.preserveindent = true
vim.o.expandtab = false
