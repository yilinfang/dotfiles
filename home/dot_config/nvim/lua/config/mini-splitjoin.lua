-- lua/config/mini-splitjoin.lua
-- Configuration for `mini.splitjoin`

local splitjoin = require('mini.splitjoin')
local opts = {}
splitjoin.setup(opts)

-- Keymaps for `mini.splitjoin`
vim.keymap.set(
  'n',
  '<leader>j',
  '<cmd>lua MiniSplitjoin.toggle()<cr>',
  { desc = '[J]oin/Split Arguments List' }
)
