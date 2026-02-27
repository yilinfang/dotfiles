-- lua/config/copilot.lua
-- Configuration for `copilot.vim`
-- NOTE: Deprecated but kept for reference

local copilot_disabled_filetypes = vim.g.copilot_disabled_filetypes
  or {
    'fzf',
    'help',
    'netrw',
    'neo-tree',
    'minifiles',
    'tutor',
    'man',
    'qf',
    '', -- Unknown filetype
  }

local copilot_disabled_buftypes = vim.g.copilot_disabled_buftypes
  or {
    'help',
    'nofile',
    'prompt',
    'quickfix',
    'acwrite',
  }

local function should_enable_copilot()
  local bo = vim.bo
  local ft = bo.filetype
  local bt = bo.buftype
  -- Disable copilot if current buffer is not modifiable
  if not bo.modifiable then return false end
  -- Disable copilot for specific filetypes
  if vim.tbl_contains(copilot_disabled_filetypes, ft) then return false end
  -- Disable copilot for specific buftypes
  if vim.tbl_contains(copilot_disabled_buftypes, bt) then return false end
  -- Enable copilot for all other cases
  return true
end

-- Create an autocmd to eable copilot when entering a buffer
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  group = vim.api.nvim_create_augroup('enable-copilot-buf-enter', { clear = true }),
  callback = function()
    if should_enable_copilot() then
      vim.b.copilot_enabled = true
    else
      vim.b.copilot_enabled = false
    end
  end,
})

-- Disable Copilot in terminal
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  group = vim.api.nvim_create_augroup('disable-copilot-term-open', { clear = true }),
  callback = function() vim.b.copilot_enabled = false end,
})

-- HACK: Map <leader>tc to toggle copilot
vim.keymap.set('n', '<leader>tc', function()
  vim.b.copilot_enabled = not vim.b.copilot_enabled
  if vim.b.copilot_enabled then
    vim.notify('Copilot: enabled', vim.log.levels.INFO)
  else
    vim.notify('Copilot: disabled', vim.log.levels.INFO)
  end
end, { desc = 'Toggle Copilot' })

vim.cmd([[

" Modify default keybindings for `copilot.vim`
imap <silent><script><expr> <M-y> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true " Disable default tab mapping
imap <M-d> <Plug>(copilot-dismiss)
imap <M-n> <Plug>(copilot-next)
imap <M-p> <Plug>(copilot-previous)
imap <M-\> <Plug>(copilot-suggest)
imap <M-w> <Plug>(copilot-accept-word)
imap <M-l> <Plug>(copilot-accept-line)

]])
