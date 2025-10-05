-- lua/plugins/config/mini/indentscope.lua
-- Configuration for `mini.indentscope`

local indentscope = require "mini.indentscope"
local opts = {
  draw = {
    delay = 0,
    animation = indentscope.gen_animation.none(),
  },
  options = { try_as_border = true },
}
indentscope.setup(opts)
