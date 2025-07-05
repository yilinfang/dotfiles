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
vim.cmd "syntax off | colorscheme retrobox | highlight Normal guifg=#ffaf00 guibg=#282828"
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
vim.o.wrap = false
vim.o.linebreak = true

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

-- Move Lines with Alt/Opt + j/k
--  from LazyVim (https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua)
vim.keymap.set({ "n" }, "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
vim.keymap.set({ "n" }, "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
vim.keymap.set({ "v" }, "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
vim.keymap.set({ "v" }, "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- Automatically resize splits when the window is resize
--  It will resize all splits to have equal height and width,
--  but not preserve the current size of splits.
vim.api.nvim_create_autocmd("VimResized", {
  desc = "Automatically resize splits when the window is resized",
  group = vim.api.nvim_create_augroup("resize-splits", { clear = true }),
  command = "windo wincmd = ",
})
