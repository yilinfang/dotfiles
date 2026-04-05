-- lua/config/mini-bufremove.lua
-- Configuration of `mini.bufremove`

local bufremove = require('mini.bufremove')
local opts = { silent = false }
bufremove.setup(opts)

-- Keymaps
vim.keymap.set(
  'n',
  '<leader>d',
  function() bufremove.delete(0, false) end,
  { desc = '[D]elete current buffer' }
)
