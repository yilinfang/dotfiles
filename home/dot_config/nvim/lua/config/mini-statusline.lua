-- lua/config/mini-statusline.lua
-- Configuration for `mini.statusline`
-- NOTE: `mini.icons` and `gitsigns.nvim` (can be `mini.git` and `mini.diff`) must be loaded before `mini.statusline`

local statusline = require("mini.statusline")
local opts = {}
statusline.setup(opts)
