-- lua/plugins/mini-snippets.lua
-- Configuration for `mini.snippets`
-- NOTE: `friendly-snippets` is required.

local snippets = require('mini.snippets')
local gen_loader = snippets.gen_loader
local snippets_path = vim.fn.stdpath('config') .. '/snippets/'
local opts = {
  snippets = {
    -- Load custom snippets
    gen_loader.from_file(snippets_path .. 'global.json'),

    -- Load snippets based on current language by reading files from
    -- "snippets/" subdirectories from 'runtimepath' directories.
    -- NOTE: `friendly-snippets` will be loaded this way.
    gen_loader.from_lang(),
  },
}
snippets.setup(opts)
