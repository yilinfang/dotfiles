-- Set space as leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Options ]]
vim.cmd('syntax off')
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.background = 'dark'
vim.opt.termguicolors = true
vim.cmd.colorscheme('retrobox')

-- [[ Keymaps ]]
vim.keymap.set('n', '<leader>/', '<cmd>noh<CR>')
vim.keymap.set('n', '<leader>r', '<cmd>e!<CR>')
vim.keymap.set('v', '<leader>y', '"+y<CR>')

-- [[ Autocmds ]]
-- Resize splits on window resize
vim.api.nvim_create_autocmd('VimResized', {
  group = vim.api.nvim_create_augroup('resize_splits', { clear = true }),
  callback = function() vim.cmd('wincmd =') end,
})
-- Disable treesitter
vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('DisableTreesitter', { clear = true }),
  callback = function() vim.treesitter.stop() end,
})

-- [[ Custom Modules ]]
-- Copy code reference
local function copy_selection_ref(relative)
  local filepath = relative and vim.fn.expand('%:.') or vim.fn.expand('%:p')
  local line1 = vim.fn.line('v')
  local line2 = vim.fn.line('.')
  local start_line = math.min(line1, line2)
  local end_line = math.max(line1, line2)
  local ref
  if start_line == end_line then
    ref = string.format('%s:%d', filepath, start_line)
  else
    ref = string.format('%s:%d-%d', filepath, start_line, end_line)
  end
  vim.fn.setreg('+', ref)
  vim.schedule(function() vim.notify('Copied: ' .. ref, vim.log.levels.INFO) end)
end
vim.keymap.set('v', '<leader>cr', function()
  copy_selection_ref(true)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', false)
end)
vim.keymap.set('v', '<leader>cR', function()
  copy_selection_ref(false)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', false)
end)
