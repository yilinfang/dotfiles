-- lua/plugins/mini-snippets.lua
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
}
snippets.setup(opts)
