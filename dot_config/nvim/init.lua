-- Yilin Fang's personal Neovim configuration
-- Vanilla Neovim configuration without external plugins or dependencies
-- Inspired from yobibyte's Neovim configuration (https://github.com/yobibyte/yobitools/blob/main/dotfiles/init.lua)
-- Copyright (c) 2025 Yilin Fang

-- [[ Global settings ]]
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

-- [[ Imported from yobibyte's configuration ]]
vim.o.undofile = true
vim.o.laststatus = 0
vim.keymap.set("n", "<leader>f", function() vim.fn.setreg("+", vim.fn.expand "%:p") end)
vim.keymap.set("n", "<leader>c", function()
  vim.ui.input({}, function(c)
    if c and c ~= "" then
      vim.cmd "noswapfile vnew"
      vim.bo.buftype = "nofile"
      vim.bo.bufhidden = "wipe"
      vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.fn.systemlist(c))
    end
  end)
end)

-- [[ Other customized settings ]]
vim.cmd "colorscheme retrobox"
vim.o.autoindent = true
vim.o.breakindent = true
vim.o.copyindent = true
vim.o.expandtab = false
vim.o.ignorecase = true
vim.o.linebreak = true
vim.o.preserveindent = true
vim.o.scrolloff = 10
vim.o.sidescrolloff = 10
vim.o.shiftround = true
vim.o.shiftwidth = 4
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.softtabstop = 4
vim.o.tabstop = 4
vim.o.wrap = false

-- [[ Keymaps ]]
vim.keymap.set("n", "<leader>/", "<cmd>noh<cr>", { desc = "Clear search highlight" })
vim.keymap.set("n", "<leader>y", "<cmd>%y+<cr>", { desc = "Yank entire buffer to system clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank selection to system clipboard" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })
vim.keymap.set("n", "<C-S-j>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<C-S-k>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<C-S-h>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<C-S-l>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })
-- Move Lines with Alt/Opt + j/k
--  from LazyVim (https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua)
vim.keymap.set("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
vim.keymap.set("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
vim.keymap.set("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- [[ Autocomds ]]
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function() vim.hl.on_yank() end,
})
vim.api.nvim_create_autocmd("VimResized", {
  desc = "Automatically resize splits when the window is resized",
  group = vim.api.nvim_create_augroup("resize-splits", { clear = true }),
  command = "windo wincmd = ",
})

-- [[ Custom modules ]]
require("detect-indent").setup()
