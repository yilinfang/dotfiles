-- lua/config/nightfly.lua
-- Configuration for `nightfly` colorscheme

vim.g.nightflyCursorColor = true
vim.g.nightflyItalics = true
vim.g.nightflyNormalFloat = true
vim.g.nightflyTerminalColors = true
vim.g.nightflyTransparent = false
vim.g.nightflyUndercurls = true
vim.g.nightflyUnderlineMatchParen = true
vim.g.nightflyVirtualTextColor = true
vim.g.nightflyWinSeparator = 2

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'nightfly',
  group = vim.api.nvim_create_augroup('nightfly_custom_highlight', { clear = true }),
  callback = function()
    local palette = require('nightfly').palette
    local set_hl = vim.api.nvim_set_hl

    -- HACK: Fix colors for `copilot.vim`
    set_hl(0, 'CopilotSuggestion', { fg = palette.grey_blue })
  end,
})

vim.cmd([[ colorscheme nightfly ]])
