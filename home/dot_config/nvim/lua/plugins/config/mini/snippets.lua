-- lua/plugins/mini/snippets.lua
-- Configuration for `mini.snippets`
-- NOTE: `friendly-snippets` is required.

local snippets = require "mini.snippets"
local opts = {
  snippets = {
    snippets.gen_loader.from_lang(), -- Load `friendly-snippets``
  },
}
snippets.setup(opts)
