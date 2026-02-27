-- lua/config/render-markdown.lua
-- Configuration for `render-markdown.nvim`
-- NOTE: Deprecated but kept for reference

local rm = require('render-markdown')
local opts = {
  -- NOTE: Get completions from render-markdown.nvim
  completions = { lsp = { enabled = true } },
}
rm.setup(opts)

-- HACK: Map <leader>tm to toggle render-markdown
vim.keymap.set('n', '<leader>tm', function() rm.toggle() end, { desc = 'Toggle RenderMarkdown' })
