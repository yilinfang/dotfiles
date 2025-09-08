-- lua/plugins/config/mini/splitjoin.lua
-- Configuration for `mini.splitjoin`

local splitjoin = require "mini.splitjoin"
local opts = {}
splitjoin.setup(opts)

-- Keymaps for `mini.splitjoin`
vim.keymap.set("n", "<leader>cj", "<cmd>lua MiniSplitjoin.toggle()<cr>", { desc = "Split code structure" })
