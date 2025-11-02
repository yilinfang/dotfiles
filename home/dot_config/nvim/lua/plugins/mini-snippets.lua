-- lua/plugins/mini-snippets.lua
-- Configuration for `mini.snippets`

local snippets = require('mini.snippets')
local gen_loader = snippets.gen_loader
-- NOTE: Put snippets for `mini.snippets` in a separate folder, since
--  it does not support vscode-style snippet yet.
local snippets_path = vim.fn.stdpath('config') .. '/snippets/mini/'
local lang_patterns = {
  markdown_inline = { 'markdown.json' },
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
