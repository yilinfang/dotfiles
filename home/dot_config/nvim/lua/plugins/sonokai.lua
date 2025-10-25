-- lua/plugins/sonokai.lua
-- Configuration of `sonokai` colorscheme

-- HACK: Fix highlights for other plugins
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'sonokai',
  group = vim.api.nvim_create_augroup('sonokai_custom_highlight', { clear = true }),
  callback = function()
    local get_hl = vim.api.nvim_get_hl
    local set_hl = vim.api.nvim_set_hl

    -- HACK: Fix colors for `copilot.vim` with Comment highlight but italic
    local comment_hl = get_hl(0, { name = 'Comment' })
    set_hl(0, 'CopilotSuggestion', { fg = comment_hl.fg, italic = true })

    -- HACK: Fix colors for lua/plugins/custom/statuscolumn.lua with CursorLineNr highlight
    local curlineNr_hl = get_hl(0, { name = 'CursorLineNr' })
    set_hl(0, 'StatusColumnMark', { fg = curlineNr_hl.fg })
  end,
})

vim.cmd([[

" Enable true color support if terminal supports it
if has('termguicolors')
  set termguicolors
endif
" Configuration for `sonokai` colorscheme
let g:sonokai_style = 'default' " 'default', 'atlantis', 'andromeda', 'maia', 'shusia' and 'espresso'
" I don't like italic font variants
let g:sonokai_disable_italic_comment = 1
let g:sonokai_enable_italic = 0
let g:sonokai_cursor = 'auto'
let g:sonokai_transparent_background = 0
let g:sonokai_dim_inactive_windows = 0
let g:sonokai_menu_selection_background = 'blue'
let g:sonokai_spell_foreground = 'none'
let g:sonokai_show_eob = 1
let g:sonokai_float_style = 'none'
let g:sonokai_diagnostic_text_highlight = 0
let g:sonokai_diagnostic_line_highlight = 0
let g:sonokai_diagnostic_virtual_text = 'colored'
let g:sonokai_current_word = 'grey background'
let g:sonokai_inlay_hints_background = 'none'
" I rarely use terminal in Neovim
let g:sonokai_disable_terminal_colors = 1
let g:sonokai_better_performance = 1
" Enable the colorscheme
colorscheme sonokai

]])
