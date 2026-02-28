-- lua/config/carbonfox.lua
-- Configuration of `carbonfox` colorscheme from `nightfox.nvim`

local nightfox = require('nightfox')
local opts = {}
nightfox.setup(opts)

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'carbonfox',
  group = vim.api.nvim_create_augroup('kanagawa_custom_highlight', { clear = true }),
  callback = function()
    local get_hl = vim.api.nvim_get_hl
    local set_hl = vim.api.nvim_set_hl

    -- HACK: Fix colors for lua/custom/statuscolumn.lua with CursorLineNr highlight
    local curlineNr_hl = get_hl(0, { name = 'CursorLineNr' })
    set_hl(0, 'StatusColumnMark', { fg = curlineNr_hl.fg })
  end,
})

vim.cmd.colorscheme('carbonfox')
