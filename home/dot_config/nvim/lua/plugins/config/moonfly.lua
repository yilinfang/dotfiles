-- lua/plugins/config/moonfly.lua
-- Configuration for `moonfly` colorscheme
-- NOTE: Deprecated

vim.g.moonflyCursorColor = true
vim.g.moonflyItalics = true
vim.g.moonflyNormalFloat = true
vim.g.moonflyTerminalColors = true
vim.g.moonflyTransparent = false
vim.g.moonflyUndercurls = true
vim.g.moonflyUnderlineMatchParen = true
vim.g.moonflyVirtualTextColor = true
vim.g.moonflyWinSeparator = 2

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "moonfly",
  group = vim.api.nvim_create_augroup("moonfly_custom_highlight", { clear = true }),
  callback = function()
    local palette = require("moonfly").palette
    local set_hl = vim.api.nvim_set_hl

    -- HACK: Fix colors for `copilot.vim`
    set_hl(0, "CopilotSuggestion", { fg = palette.grey58 })

    -- HACK: Fix colors for ./lua/plugins/custom/statuscolumn.lua
    set_hl(0, "StatusColumnMark", { fg = palette.blue })
  end,
})

vim.cmd [[ colorscheme moonfly ]]
