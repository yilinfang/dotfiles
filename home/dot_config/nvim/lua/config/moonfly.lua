-- lua/config/moonfly.lua
-- Configuration for `moonfly` colorscheme

vim.g.moonflyCursorColor = true
vim.g.moonflyItalics = false
vim.g.moonflyNormalPmenu = false
vim.g.moonflyNormalFloat = false
vim.g.moonflyTerminalColors = true
vim.g.moonflyTransparent = false
vim.g.moonflyUndercurls = true
vim.g.moonflyUnderlineMatchParen = true
vim.g.moonflyVirtualTextColor = true
vim.g.moonflyWinSeparator = 2

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'moonfly',
  group = vim.api.nvim_create_augroup('moonfly_custom_highlight', { clear = true }),
  callback = function()
    local get_hl = vim.api.nvim_get_hl
    local set_hl = vim.api.nvim_set_hl

    -- HACK: Fix colors for Copilot Suggestions
    set_hl(
      0,
      'CopilotSuggestion',
      { fg = vim.g.terminal_color_8, italic = not vim.g.moonflyItalics }
    )

    -- HACK: Fix colors for lua/user/statuscolumn.lua
    local curlineNr_hl = get_hl(0, { name = 'CursorLineNr' })
    set_hl(0, 'StatusColumnMark', { fg = curlineNr_hl.fg })
  end,
})

vim.cmd.colorscheme('moonfly')
