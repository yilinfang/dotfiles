-- lua/plugins/mini-bufremove.lua
-- Configuration of `mini.bufremove`

local bufremove = require('mini.bufremove')
local opts = { silent = false }
bufremove.setup(opts)

-- Keymaps
vim.keymap.set(
  'n',
  '<leader>bd',
  function() bufremove.delete(0, false) end,
  { desc = 'mini.[b]ufremove: [d]elete current buffer' }
)
