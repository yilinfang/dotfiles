-- lua/config/moonfly.lua
-- Configuration for `moonfly` colorscheme

vim.g.moonflyCursorColor = true
vim.g.moonflyItalics = true
vim.g.moonflyNormalFloat = true
vim.g.moonflyTerminalColors = true
vim.g.moonflyTransparent = false
vim.g.moonflyUndercurls = true
vim.g.moonflyUnderlineMatchParen = true
vim.g.moonflyVirtualTextColor = true
vim.g.moonflyWinSeparator = 2

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'moonfly',
  group = vim.api.nvim_create_augroup(
    'moonfly_custom_highlight',
    { clear = true }
  ),
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

vim.cmd.colorscheme('moonfly')
