-- lua/config/mini-minischeme.lua
-- Configuration for colorschemes in `mini.base16`
-- TODO: Create a custom theme based on `mini.base16`

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'minischeme',
  group = vim.api.nvim_create_augroup('minischeme_custom_highlight', { clear = true }),
  callback = function()
    local set_hl = vim.api.nvim_set_hl

    -- -- HACK: Fix colors for `copilot.vim` with Comment highlight
    -- local comment_hl = vim.api.nvim_get_hl(0, { name = 'Comment' })
    -- set_hl(0, 'CopilotSuggestion', { fg = comment_hl.fg, italic = true })

    -- HACK: Use terminal color 8 (BrightBlack) for Copilot suggestions
    set_hl(0, 'CopilotSuggestion', { fg = vim.g.terminal_color_8 })

    -- HACK: Fix colors for lua/custom/statuscolumn.lua with CursorLineNr highlight
    local curlineNr_hl = vim.api.nvim_get_hl(0, { name = 'CursorLineNr' })
    set_hl(0, 'StatusColumnMark', { fg = curlineNr_hl.fg })
  end,
})

vim.cmd.colorscheme('minischeme')
