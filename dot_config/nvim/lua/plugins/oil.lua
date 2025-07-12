-- lua/plugins/oil.lua
-- HACK: Oil.nvim for file management

return {
  "stevearc/oil.nvim",
  lazy = false, -- NOTE: Lazy loading is disabled for oil.nvim
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
  keys = {
    {
      "<leader>e",
      function() require("oil").open() end,
      desc = "Open File [E]xplorer",
    },
  },
}
