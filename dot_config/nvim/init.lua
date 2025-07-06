-- Yilin Fang's personal Neovim configuration
-- Vanilla neovim without any plugins.
-- Inspired from yobibyte's neovim configuration (https://github.com/yobibyte/yobitools/blob/main/dotfiles/init.lua)
-- Copyright (c) 2025 Yilin Fang

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ Imported from yobibyte's configuration]]
vim.o.undofile = true
vim.o.laststatus = 0
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.softtabstop = -1
vim.keymap.set("n", "<leader>y", function() vim.fn.setreg("+", vim.fn.expand "%:p") end)
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

-- [[ Customized configuration ]]

vim.cmd [[colorscheme retrobox]]
vim.o.wrap = false

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

vim.keymap.set({ "n", "v" }, "<M-S-a>", "<Esc>ggVG", { desc = "Select all text in the current buffer" })
vim.keymap.set({ "v" }, "<M-S-y>", '"+y"', { desc = "Yank selected text to the system clipboard" })
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

-- Automatically resize splits when the window is resize
--  It will resize all splits to have equal height and width,
--  but not preserve the current size of splits.
vim.api.nvim_create_autocmd("VimResized", {
  desc = "Automatically resize splits when the window is resized",
  group = vim.api.nvim_create_augroup("resize-splits", { clear = true }),
  command = "windo wincmd = ",
})
