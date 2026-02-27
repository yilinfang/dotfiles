-- lua/config/mini-snippets.lua
-- Configuration for `mini.snippets`

local snippets = require('mini.snippets')
local gen_loader = snippets.gen_loader
local snippets_path = vim.fn.stdpath('config') .. '/snippets/'
local lang_patterns = {
  -- NOTE: Add language patterns as needed
  -- markdown_inline = { 'markdown.json' },
}
local opts = {
  snippets = {
    -- Load custom global snippets
    gen_loader.from_file(snippets_path .. 'global.json'),

    -- Load language-specific snippets, put them in `snippets/` subdirectories
    -- of your `runtimepath` directories(e.g., in `$XDG_CONFIG_HOME/nvim/snippets/`).
    -- NOTE: `friendly-snippets` will be loaded this way.
    gen_loader.from_lang({ lang_patterns = lang_patterns }),
  },
  mappings = {
    -- NOTE: Disable default mapping for expanding snippets since I don't like
    -- the default behavior.
    expand = '',
  },
}
snippets.setup(opts)

-- -- NOTE: Start LSP server for snippets so that they show up in `mini.completion`
-- snippets.start_lsp_server()

-- HACK: Remapping snippet expansion to Ctrl+j with custom behavior
vim.keymap.set('i', '<C-j>', function()
  snippets.expand({
    match = function(s)
      return snippets.default_match(s, {
        -- NOTE: Only insert the snippet if there's an exact match
        pattern_exact_boundary = '.?',
        pattern_fuzzy = '',
      })
    end,
    select = false,
  })
end, { desc = 'Match and force expand the best match (if any)' })
