-- lua/config/mini-files.lua
-- Configuration for `mini.files`

local files = require('mini.files')
local opts = {
  windows = {
    preview = true,
    width_focus = 30,
    -- Width of non-focused window
    width_nofocus = 15,
    -- Width of preview window
    width_preview = 50,
  },
}
files.setup(opts)

-- Keymap to open the file explorer
vim.keymap.set(
  'n',
  '<leader>e',
  '<cmd>lua MiniFiles.open()<cr>',
  { desc = 'Open Files [E]xplorer' }
)

-- HACK: Create an autocommand group to set bookmarks when the explorer is opened
-- From: https://github.com/echasnovski/nvim/blob/8d89ed1136e60e68bb9ac0b0565071225376a92e/plugin/20_mini.lua#L242
vim.api.nvim_create_autocmd('User', {
  group = vim.api.nvim_create_augroup('create-bookmarks-on-mini-files-open', { clear = true }),
  pattern = 'MiniFilesExplorerOpen',
  callback = function() files.set_bookmark('w', vim.fn.getcwd, { desc = 'Working Directory' }) end,
})
