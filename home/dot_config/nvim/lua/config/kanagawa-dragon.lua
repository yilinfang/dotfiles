-- lua/config/kanagawa-dragon.lua
-- Configuration for kanagawa.nvim's dragon variant

local kanagawa = require('kanagawa')
local opts = {
  -- Disable some preset styles
  commentStyle = { italic = false },
  statementStyle = { bold = false },
  overrides = function(colors)
    return {
      -- HACK: Disable bold for booleans
      --  https://github.com/rebelot/kanagawa.nvim/issues/235#issuecomment-2104670214
      Boolean = { bold = false },
    }
  end,
  theme = 'dragon',
  background = {
    dark = 'dragon',
    light = 'lotus',
  },
}
kanagawa.setup(opts)

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'kanagawa',
  group = vim.api.nvim_create_augroup('kanagawa_custom_highlight', { clear = true }),
  callback = function()
    local set_hl = vim.api.nvim_set_hl

    -- -- HACK: Fix colors for `copilot.vim` with Comment highlight
    -- local comment_hl = vim.api.nvim_get_hl(0, { name = 'Comment' })
    -- set_hl(0, 'CopilotSuggestion', { fg = comment_hl.fg })

    -- -- HACK: Use terminal color 8 (BrightBlack) for Copilot suggestions
    -- set_hl(0, 'CopilotSuggestion', { fg = vim.g.terminal_color_8 })

    -- HACK: Fix colors for lua/user/statuscolumn.lua with CursorLineNr highlight
    local curlineNr_hl = vim.api.nvim_get_hl(0, { name = 'CursorLineNr' })
    set_hl(0, 'StatusColumnMark', { fg = curlineNr_hl.fg })
  end,
})

vim.cmd.colorscheme('kanagawa')
