-- lua/config/catppuccin.lua
-- Configuration for theme Catppuccin

local catppuccin = require('catppuccin')
local opts = {
  flavour = 'macchiato', -- latte, frappe, macchiato, mocha
  background = {
    light = 'latte',
    dark = 'macchiato',
  },
}
catppuccin.setup(opts)

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'catppuccin',
  group = vim.api.nvim_create_augroup('catppuccin_custom_highlight', { clear = true }),
  callback = function()
    local set_hl = vim.api.nvim_set_hl

    -- HACK: Fix colors for `copilot.vim` with Comment highlight
    local comment_hl = vim.api.nvim_get_hl(0, { name = 'Comment' })
    set_hl(0, 'CopilotSuggestion', { fg = comment_hl.fg })

    -- HACK: Fix colors for lua/user/statuscolumn.lua with CursorLineNr highlight
    local curlineNr_hl = vim.api.nvim_get_hl(0, { name = 'CursorLineNr' })
    set_hl(0, 'StatusColumnMark', { fg = curlineNr_hl.fg })
  end,
})

vim.cmd.colorscheme('catppuccin')
