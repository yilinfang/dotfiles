-- [[ Basic Keymaps ]]
-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- HACK: Map <M-S-a> to select all text in the current buffer
vim.keymap.set({ "n", "v" }, "<M-S-a>", "<Esc>ggVG", { desc = "Select all text in the current buffer" })

-- HACK: Map <M-S-y> to copy the selected text to the system clipboard "+
vim.keymap.set({ "v" }, "<M-S-y>", '"+y"', { desc = "Yank selected text to the system clipboard" })

-- HACK: Toggle spell checking in the current buffer
vim.keymap.set("n", "<leader>ts", function()
  vim.opt_local.spell = not vim.opt_local.spell:get()
  local status = vim.opt_local.spell:get() and "ON" or "OFF"
  print("Spell check: " .. status)
end, { desc = "[T]oggle [S]pell Check" })

-- HACK: Toggle wrap in the current buffer
vim.keymap.set("n", "<leader>tw", function()
  vim.opt_local.wrap = not vim.opt_local.wrap:get()
  local status = vim.opt_local.wrap:get() and "ON" or "OFF"
  print("Wrap: " .. status)
end, { desc = "[T]oggle [W]rap" })
