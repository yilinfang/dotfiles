-- lua/plugins/kanagawa.lua
-- Configuration for kanagawa.nvim

local kanagawa = require('kanagawa')
local opts = {
  theme = 'wave',
  background = {
    dark = 'wave',
    light = 'lotus',
  },
}
kanagawa.setup(opts)

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'kanagawa',
  group = vim.api.nvim_create_augroup('kanagawa_custom_highlight', { clear = true }),
  callback = function()
    local set_hl = vim.api.nvim_set_hl

    -- HACK: Fix colors for `copilot.vim` with Comment highlight
    local comment_hl = vim.api.nvim_get_hl(0, { name = 'Comment' })
    set_hl(0, 'CopilotSuggestion', { fg = comment_hl.fg })

    -- HACK: Fix colors for lua/plugins/custom/statuscolumn.lua with CursorLineNr highlight
    local curlineNr_hl = vim.api.nvim_get_hl(0, { name = 'CursorLineNr' })
    set_hl(0, 'StatusColumnMark', { fg = curlineNr_hl.fg })
  end,
})

vim.cmd.colorscheme('kanagawa')
