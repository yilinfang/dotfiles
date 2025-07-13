-- lua/plugins/oil.lua
-- HACK: Oil.nvim for file management

return {
  "stevearc/oil.nvim",
  lazy = false, -- NOTE: Lazy loading is disabled for oil.nvim
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    default_file_explorer = true,
    columns = {
      "permissions",
      "size",
      "mtime",
      "icon",
    },
    watch_for_changes = true,
  },
  keys = {
    {
      "<leader>e",
      function() require("oil").open() end,
      desc = "Open File [E]xplorer",
    },
  },
}
