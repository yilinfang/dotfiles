-- lua/plugins/persistence.lua
-- HACK: persistence.nvim

return {
  "folke/persistence.nvim",
  event = "BufReadPre", -- this will only start session saving when an actual file was opened
  opts = {},
}
