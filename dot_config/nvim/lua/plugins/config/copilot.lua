-- lua/plugins/config/copilot.lua
-- Configuration for copilot.vim

vim.b.copilot_enabled = false -- Disable copilot by default
vim.g.copilot_not_tab_map = true -- Disable tab mapping for copilot

-- [[ Key Mappings ]]
vim.keymap.set("i", "<M-y>", 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
})
vim.keymap.set("i", "<M-d>", "<Plug>(copilot-dismiss)")
vim.keymap.set("i", "<M-n>", "<Plug>(copilot-next)")
vim.keymap.set("i", "<M-p>", "<Plug>(copilot-previous)")
vim.keymap.set("i", "<M-.>", "<Plug>(copilot-suggest)")
vim.keymap.set("i", "<M-w>", "<Plug>(copilot-accept-word)")
vim.keymap.set("i", "<M-l>", "<Plug>(copilot-accept-line)")

-- HACK: Map <leader>tc to toggle copilot
vim.keymap.set("n", "<leader>tc", function()
  vim.b.copilot_enabled = not vim.b.copilot_enabled
  if vim.b.copilot_enabled then
    vim.notify("Copilot enabled", vim.log.levels.INFO)
  else
    vim.notify("Copilot disabled", vim.log.levels.INFO)
  end
end, { desc = "Toggle Copilot" })
