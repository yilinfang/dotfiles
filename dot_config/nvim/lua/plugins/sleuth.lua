-- lua/plugins/sleuth.lua
-- Auto-detect indentation settings for files

if true then return {} end -- Disbale vim-sleuth for now

return {
  "tpope/vim-sleuth",
  event = "VeryLazy",
  -- No specific configuration needed for vim-sleuth
  -- It automatically detects and sets the indentation settings
  config = function() end,
}
