-- lua/plugins/tokyonight.lua
-- Configuration for theme `tokyonight.nvim`

local tokyonight = require('tokyonight')
local opts = {
  style = 'night',
  styles = {
    comments = { italic = false },
    keywords = { italic = false },
    functions = { italic = false },
    variables = { italic = false },
  },
  plugins = {
    all = true, -- NOTE: Enable all plugins
    auto = false, -- NOTE: We are not using `lazy.nvim`
  },
}
tokyonight.setup(opts)

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'tokyonight',
  group = vim.api.nvim_create_augroup('tokyonight_custom_highlight', { clear = true }),
  callback = function()
    local set_hl = vim.api.nvim_set_hl

    -- HACK: Fix colors for `copilot.vim` with Comment highlight
    local comment_hl = vim.api.nvim_get_hl(0, { name = 'Comment' })
    set_hl(0, 'CopilotSuggestion', { fg = comment_hl.fg, italic = true })

    -- HACK: Fix colors for lua/plugins/custom/statuscolumn.lua with CursorLineNr highlight
    local curlineNr_hl = vim.api.nvim_get_hl(0, { name = 'CursorLineNr' })
    set_hl(0, 'StatusColumnMark', { fg = curlineNr_hl.fg })
  end,
})

vim.cmd.colorscheme('tokyonight')
