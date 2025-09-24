-- lua/plugins/config/mini/indentscope.lua
-- Configuration for `mini.indentscope`

-- NOTE: Do not show indent guides
-- We only use textobject feature
vim.g.miniindentscope_disable = true

local indentscope = require "mini.indentscope"
local opts = {}
indentscope.setup(opts)
