vim.cmd([[

" Options
syntax off
set number
set mouse=a
set background=dark
set termguicolors
colorscheme retrobox
" Keymaps
" Use space as leader key
let g:mapleader = "\<Space>"
nnoremap <leader>/ :noh<CR>
nnoremap <leader>r :e!<CR>
vnoremap <leader>y "+y<CR>
" Autogroups
" Resize splits if window got resized
augroup resize_splits
  autocmd!
  autocmd VimResized * wincmd =
augroup END
" Disable treesitter in Neovim
augroup DisableTreesitter
  autocmd!
  autocmd BufEnter * lua vim.treesitter.stop()
augroup END

]])

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
  vim.schedule(function()
    vim.notify('Copied: ' .. ref, vim.log.levels.INFO)
  end)
end

vim.keymap.set('v', '<leader>cr', function()
  copy_selection_ref(true)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', false)
end, { desc = '[C]opy relative code [r]eference for coding agents' })

vim.keymap.set('v', '<leader>cR', function()
  copy_selection_ref(false)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', false)
end, { desc = 'Copy absolute code [r]eference for coding agents' })
