-- lua/config/everforest.lua
-- Configuration for the Everforest colorscheme

vim.g.everforest_background = 'hard' -- "soft", "medium", or "hard"
vim.g.everforest_enable_italic = true
vim.g.everforest_diagnostic_virtual_text = 'colored'
vim.g.everforest_better_performance = 1

-- HACK: Fix highlights for other plugins
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'everforest',
  group = vim.api.nvim_create_augroup('everforest_custom_highlight', { clear = true }),
  callback = function()
    local config = vim.fn['everforest#get_configuration']()
    local palette =
      vim.fn['everforest#get_palette'](config.background or 'medium', config.colors_override or {})

    -- HACK: Fix highlights for terminal
    vim.g.terminal_color_8 = palette.grey1
  end,
})

vim.cmd.colorscheme('everforest')
