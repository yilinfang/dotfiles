-- lua/config/mini-diff.lua
-- Configuration for `mini.diff`

local diff = require('mini.diff')
local opts = {
  view = {
    style = 'sign',
    signs = {
      add = '+',
      change = '~',
      delete = '_',
    },
  },
}
diff.setup(opts)
