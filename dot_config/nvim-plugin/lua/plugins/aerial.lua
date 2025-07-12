-- lua/plugins/aerial.lua
-- HACK: aerial.nvim

return {
  "stevearc/aerial.nvim",
  event = { unpack(require("utils.events").LazyFile) }, -- HACK: Set the event of aerial.nvim to LazyFile
  -- Optional dependencies
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {},
  config = function(_, opts)
    require("aerial").setup(opts)
    vim.keymap.set("n", "<leader>sa", "<cmd>Telescope aerial<CR>", { desc = "[S]earch [A]erial Symbols" })
  end,
}
