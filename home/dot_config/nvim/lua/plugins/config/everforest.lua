-- lua/plugins/config/everforest.lua
-- Configuration for the Everforest colorscheme

vim.g.everforest_background = "hard" -- "soft", "medium", or "hard"
vim.g.everforest_enable_italic = true
vim.g.everforest_diagnostic_virtual_text = "colored"
vim.g.everforest_better_performance = 1

-- HACK: Fix highlights for other plugins
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "everforest",
  group = vim.api.nvim_create_augroup("everforest_custom_highlight", { clear = true }),
  callback = function()
    local config = vim.fn["everforest#get_configuration"]()
    local palette = vim.fn["everforest#get_palette"](config.background or "medium", config.colors_override or {})

    -- HACK: Fix highlights for terminal
    vim.g.terminal_color_8 = palette.grey1

    -- Fix highlights for fzf-lua
    -- NOTE: Deprecated but kept for reference
    -- local set_hl = vim.fn["everforest#highlight"]
    -- set_hl("FzfLuaBackdrop", palette.none, palette.bg_dim)
    -- set_hl("FzfLuaHeaderBind", palette.fg, palette.none)
    -- set_hl("FzfLuaHeaderText", palette.red, palette.none)
    -- set_hl("FzfLuaPathColNr", palette.blue, palette.none)
    -- set_hl("FzfLuaPathLineNr", palette.green, palette.none)
    -- set_hl("FzfLuaBufNr", palette.fg, palette.none)
    -- set_hl("FzfLuaBufFlagCur", palette.red, palette.none)
    -- set_hl("FzfLuaBufFlagAlt", palette.blue, palette.none)
    -- set_hl("FzfLuaTabTile", palette.blue, palette.none)
    -- set_hl("FzfLuaTabMarker", palette.fg, palette.none)
    -- set_hl("FzfLuaLivePrompt", palette.red, palette.none)
    -- set_hl("FzfLuaLiveSym", palette.red, palette.none)
  end,
})

vim.cmd.colorscheme "everforest"
