-- lua/plugins/oil.lua
-- HACK: Oil.nvim for file management

return {
  "stevearc/oil.nvim",
  lazy = false, -- NOTE: Lazy loading is disabled for oil.nvim
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    default_file_explorer = false, -- Use neo-tree as the default file explorer
    columns = {}, -- Disable additional columns
    watch_for_changes = true,
    keymaps = {
      ["<C-c>"] = false,
      ["q"] = { "actions.close", mode = "n" },
    },
  },
  keys = {
    {
      "<leader>e",
      function() require("oil").open() end,
      desc = "Open Oil File [E]xplorer",
    },
  },
}
