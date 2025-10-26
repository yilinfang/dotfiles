-- lua/custom/options.lua
-- Basic options for Neovim

-- Leadey key
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Disable some providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- Clipboard
if vim.env.SSH_TTY then
  vim.g.clipboard = {
    name = 'Customized OSC 52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
      ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    paste = {
      ['+'] = function()
        local content = vim.fn.getreg('')
        return vim.split(content, '\n')
      end,
      ['*'] = function()
        local content = vim.fn.getreg('')
        return vim.split(content, '\n')
      end,
    },
  }
end

-- General options
vim.o.autoread = true
vim.o.breakindent = true
vim.o.completeopt = 'menuone,noselect,fuzzy'
vim.o.confirm = true
vim.o.cursorline = true
vim.o.ignorecase = true
vim.o.inccommand = 'split'
vim.o.linebreak = true
vim.o.mouse = 'a'
vim.o.number = true
vim.o.relativenumber = false
vim.o.scrolloff = 8
vim.o.showmode = false
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.termguicolors = true
vim.o.timeoutlen = 300
vim.o.undofile = true
vim.o.updatetime = 250
vim.o.wrap = false

-- List chars
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

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
