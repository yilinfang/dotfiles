-- lua/config/aerial.lua
-- Configuration for `aerial.nvim`
-- NOTE: Deprecated but kept for reference

local aerial = require('aerial')
local opts = {
  backends = { 'lsp', 'treesitter', 'markdown', 'man' },
  layout = {
    max_width = { 80, 0.4 },
    width = 40,
    min_width = 10,
    win_opts = {
      -- NOTE: Disable signcolumn and statuscolumn in aerial window
      signcolumn = 'auto',
      statuscolumn = '',
    },
    default_direction = 'prefer_right',
    placement = 'edge',
    resize_to_content = false,
  },
  show_guides = true,
  guides = {
    mid_item = '├╴',
    last_item = '└╴',
    nested_top = '│ ',
    whitespace = '  ',
  },
}
aerial.setup(opts)

vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>', { desc = 'Toggle [A]erial' })
vim.keymap.set(
  'n',
  '<leader>sa',
  function() aerial.fzf_lua_picker() end,
  { desc = '[S]earch [A]erial symbols' }
)
