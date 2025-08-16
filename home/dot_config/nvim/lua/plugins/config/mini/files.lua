-- lua/plugins/config/mini/files.lua
-- Configuration for mini.files

local files = require "mini.files"
local opts = {}
files.setup(opts)
-- Map <leader>e to open mini.files
vim.keymap.set("n", "<leader>e", "<cmd>lua MiniFiles.open()<cr>", { desc = "Open mini.files [E]xplorer" })
