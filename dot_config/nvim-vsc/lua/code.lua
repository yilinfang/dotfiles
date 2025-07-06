-- Configuration for VSCode-NeoVim integration

-- Only load this configuration if running in VSCode
if not vim.g.vscode then return end

local vscode = require "vscode"

-- Custom key mappings
vim.keymap.del({ "n", "x" }, "=")
vim.keymap.del("n", "==")
vim.keymap.set(
  "n",
  "<leader>f",
  function() vscode.action "editor.action.formatDocument" end,
  { desc = "Format Document" }
)
vim.keymap.set(
  "v",
  "<leader>f",
  function() vscode.action "editor.action.formatSelection" end,
  { desc = "Format Selection" }
)
vim.keymap.set("n", "<leader>/", "<cmd>noh<CR>", { desc = "Clear Search Highlight" })
vim.keymap.set(
  "n",
  "<leader><leader>",
  function() vscode.action "workbench.action.showCommands" end,
  { desc = "Show Command Palette" }
)
