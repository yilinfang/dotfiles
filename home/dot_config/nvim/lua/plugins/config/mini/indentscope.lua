-- lua/plugins/config/mini/indentscope.lua
-- Configuration for `mini.indentscope`

-- NOTE: Do not show indent guides
-- We only use `mini.indentscope`'s selection feature
vim.g.miniindentscope_disable = true

local indentscope = require "mini.indentscope"
local opts = {}
indentscope.setup(opts)
