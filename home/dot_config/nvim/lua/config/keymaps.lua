-- lua/custom/keymaps.lua
-- Basic keymaps for Neovim

vim.keymap.set('i', '<C-[>', '<Esc>', { desc = 'Exit insert mode' })
vim.keymap.set('n', '<leader>/', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlighting' })
vim.keymap.set('n', '<leader>d', '<cmd>bdelete<CR>', { desc = 'Delete current buffer' })
vim.keymap.set(
  'n',
  '<leader>x',
  vim.diagnostic.setloclist,
  { desc = 'Open Diagnostic Quickfi[x] List' }
)
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', 'gt', '<cmd>bnext<cr>', { desc = 'Go to next buffer' })
vim.keymap.set('n', 'gT', '<cmd>bprevious<cr>', { desc = 'Go to previous buffer' })
vim.keymap.set(
  'n',
  '<leader>f',
  function() vim.fn.setreg('+', vim.fn.expand('%:p')) end,
  { desc = 'Copy file path to system clipboard' }
)
vim.keymap.set(
  'n',
  '<leader>y',
  '<cmd>%y+<cr>',
  { desc = 'Yank entire buffer to system clipboard' }
)
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Yank selection to system clipboard' })
vim.keymap.set('n', '<leader>ts', function()
  vim.opt_local.spell = not vim.opt_local.spell:get()
  local status = vim.opt_local.spell:get() and 'ON' or 'OFF'
  print('Spell check: ' .. status)
end, { desc = '[T]oggle [S]pell Check' })
vim.keymap.set('n', '<leader>tw', function()
  vim.opt_local.wrap = not vim.opt_local.wrap:get()
  local status = vim.opt_local.wrap:get() and 'ON' or 'OFF'
  print('Wrap: ' .. status)
end, { desc = '[T]oggle [W]rap' })

-- HACK: Better up/down
--  From LazyVim: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
vim.keymap.set(
  { 'n', 'x' },
  'j',
  "v:count == 0 ? 'gj' : 'j'",
  { desc = 'Down', expr = true, silent = true }
)
vim.keymap.set(
  { 'n', 'x' },
  'k',
  "v:count == 0 ? 'gk' : 'k'",
  { desc = 'Up', expr = true, silent = true }
)
