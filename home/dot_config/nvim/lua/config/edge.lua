-- lua/config/edge.lua
-- Configuration of `edge` colorscheme

-- HACK: Fix highlights for other config
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'edge',
  group = vim.api.nvim_create_augroup('edge_custom_highlight', { clear = true }),
  callback = function()
    local get_hl = vim.api.nvim_get_hl
    local set_hl = vim.api.nvim_set_hl

    -- HACK: Fix colors for `copilot.vim` and with Comment highlight but italic
    local comment_hl = get_hl(0, { name = 'Comment' })
    set_hl(0, 'CopilotSuggestion', { fg = comment_hl.fg, italic = true })

    -- HACK: Fix colors for lua/user/statuscolumn.lua with CursorLineNr highlight
    local curlineNr_hl = get_hl(0, { name = 'CursorLineNr' })
    set_hl(0, 'StatusColumnMark', { fg = curlineNr_hl.fg })
  end,
})

vim.cmd([[

" Enable true color support if terminal supports it
if has('termguicolors')
  set termguicolors
endif
" Configuration for `edge` colorscheme
let g:edge_style = 'default' " `'default'`, `'aura'` and `'neon'`
let g:edge_dim_foreground = 0 " `0` for white, `1` for dark gray
" I don't like italic font variants
let g:edge_disable_italic_comment = 1
let g:edge_enable_italic = 0
let g:edge_cursor = 'auto'
let g:edge_transparent_background = 0
let g:edge_dim_inactive_windows = 0
let g:edge_menu_selection_background = 'blue'
let g:edge_spell_foreground = 'none'
let g:edge_show_eob = 1
let g:edge_float_style = 'blend'
let g:edge_diagnostic_text_highlight = 0
let g:edge_diagnostic_line_highlight = 0
let g:edge_diagnostic_virtual_text = 'colored'
let g:edge_current_word = 'grey background'
let g:edge_inlay_hints_background = 'none'
" I rarely use terminal in Neovim
let g:edge_disable_terminal_colors = 1
let g:edge_better_performance = 1
" Enable the colorscheme
colorscheme edge

]])
