-- lua/plugins/config/lazydev.lua
-- Configuration for `lazydev.nvim`

local lazydev = require "lazydev"
lazydev.setup {
  library = {
    -- Load luvit types when the `vim.uv` word is found
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
}
