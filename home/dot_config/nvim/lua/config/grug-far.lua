-- lua/config/grug-far.lua
-- Configuration for `grug-far.nvim`
-- NOTE: Deprecated but kept for reference

local grug_far = require('grug-far')
local opts = {}
grug_far.setup(opts)

-- Disable signcolumn and statuscolumn in grug-far window
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('grugfar_signcolumn', { clear = true }),
  pattern = 'grug-far',
  callback = function()
    vim.opt_local.signcolumn = 'auto'
    vim.opt_local.statuscolumn = ''
  end,
  desc = 'Disable signcolumn in grug-far window',
})

-- Keymaps for `grug-far.nvim`
vim.keymap.set(
  { 'n', 'v' },
  '<leader>g',
  function()
    grug_far.open({
      transient = true,
    })
  end,
  { desc = '[G]rug Far' }
)
