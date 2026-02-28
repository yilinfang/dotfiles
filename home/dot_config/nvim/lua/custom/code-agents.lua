-- lua/custom/code-agents.lua
local M = {}

function M.copy_selection_ref()
  local filepath = vim.fn.expand('%:p')
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")

  local ref
  if start_line == end_line then
    ref = string.format('%s:%d', filepath, start_line)
  else
    ref = string.format('%s:%d-%d', filepath, start_line, end_line)
  end

  vim.fn.setreg('+', ref)
  vim.notify('Copied: ' .. ref, vim.log.levels.INFO)
end

function M.setup()
  vim.keymap.set(
    'v',
    '<leader>cr',
    function() M.copy_selection_ref() end,
    { desc = 'Copy code reference for coding agents' }
  )
end

return M
