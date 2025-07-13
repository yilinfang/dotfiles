-- lua/plugins/grug-far.lua
-- HACK: grug-far.nvim for search and replace

-- CODE FROM LazyVim (Thanks Folke!)
return {
  "MagicDuck/grug-far.nvim",
  opts = { headerMaxWidth = 80 },
  cmd = "GrugFar",
  keys = {
    {
      "<leader>sR",
      function()
        local grug = require "grug-far"
        local ext = vim.bo.buftype == "" and vim.fn.expand "%:e"
        grug.open {
          transient = true,
          prefills = {
            filesFilter = ext and ext ~= "" and "*." .. ext or nil,
          },
        }
      end,
      mode = { "n", "v" },
      desc = "[S]earch and [R]eplace",
    },
  },
}
