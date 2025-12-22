-- lua/config/mini-tabline.lua
-- Configuration for `mini.tabline`

local tabline = require('mini.tabline')
local opts = {
  show_icons = true, -- Show icons in the tabline
  show_index = true, -- Show index numbers for tabs
  show_modified = true, -- Show modified status for tabs
}
tabline.setup(opts)
