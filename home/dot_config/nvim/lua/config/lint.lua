-- lua/plugin/lint.lua
-- Configuration for `nvim-lint`

local lint = require('lint')

-- Register linters for various file types
local linters_by_ft = {}
if vim.fn.executable('zsh') == 1 then linters_by_ft.zsh = { 'zsh' } end
if vim.fn.executable('fish') == 1 then linters_by_ft.fish = { 'fish' } end
if vim.fn.executable('mypy') == 1 then linters_by_ft.python = { 'mypy' } end
lint.linters_by_ft = linters_by_ft

vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  group = vim.api.nvim_create_augroup('nvim-lint', { clear = true }),
  callback = function()
    if vim.bo.modifiable then lint.try_lint() end
  end,
})
