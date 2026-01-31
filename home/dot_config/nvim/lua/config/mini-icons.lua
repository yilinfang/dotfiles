-- lua/config/mini-icons.lua
-- Configuration for `mini.icons`

local icons = require('mini.icons')
local opts = {}
icons.setup(opts)

-- Mock 'nvim-tree/nvim-web-devicons' for plugins without 'mini.icons' support
icons.mock_nvim_web_devicons()

-- Add LSP kind icons
icons.tweak_lsp_kind()
