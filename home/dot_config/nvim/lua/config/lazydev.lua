-- lua/config/lazydev.lua
-- Configuration for `lazydev.nvim`
-- NOTE: Deprecated in favor of `lua_ls` configuration

local lazydev = require('lazydev')
lazydev.setup({
  library = {
    -- Load luvit types when the `vim.uv` word is found
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
})
