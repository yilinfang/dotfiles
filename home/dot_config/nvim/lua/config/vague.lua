-- lua/config/tokyonight.lua
-- Configuration for theme `vague.nvim`

local vague = require("vague")
local opts = {
  transparent = false,
  bold = false,
  italic = false,
}
vague.setup(opts)

vim.cmd.colorscheme("vague")
