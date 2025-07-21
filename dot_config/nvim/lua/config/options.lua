-- lua/config/options.lua

-- [[ Global options ]]
-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ Setting options ]]
-- Enable linenumbers
vim.o.number = true

-- Enable relative line numbers
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- HACK: Customized OSC 52 for SSH
--  Disable paste from system clipboard
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

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.o.inccommand = "split"

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
vim.o.confirm = true

-- Disable wrap lines
vim.o.wrap = false
vim.o.linebreak = true

-- Folding
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 99

-- Indent settings
vim.o.autoindent = true -- Copy indent from current line when starting a new line
vim.o.breakindent = true -- Allow breaking of lines at indent
vim.o.copyindent = true -- Copy indent from current line when starting a new line
vim.o.expandtab = false -- Use tabs instead of spaces
vim.o.preserveindent = true -- Preserve indent structure when reindenting
vim.o.shiftround = true -- Round indent
vim.o.shiftwidth = 8 -- Size of an indent
vim.o.smartindent = true -- Smart indenting on new lines
vim.o.softtabstop = 8 -- Number of spaces a <Tab> counts for while editing
vim.o.tabstop = 8 -- Number of spaces a <Tab> counts for

-- Automatically reload files changed outside of Neovim
vim.o.autoread = true

-- HACK: Remove '~' at the end of the file
vim.opt.fillchars = { eob = " " }
