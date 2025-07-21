-- lua/plugins/tokyonight.lua
-- Tokyonight theme configuration

if true then return {} end -- Disbaled for now

return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd "colorscheme tokyonight"
  end,
}
