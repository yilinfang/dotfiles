-- HACK: aerial.nvim
return {
  "stevearc/aerial.nvim",
  event = { unpack(require("utils.events").LazyFile) }, -- HACK: Set the event of aerial.nvim to LazyFile
  -- Optional dependencies
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    layout = {
      max_width = { 50, 0.3 },
      min_width = { 20, 0.2 },
    },
  },
  config = function(_, opts)
    require("aerial").setup(opts)
    vim.keymap.set("n", "<leader>ta", "<cmd>AerialToggle right<CR>", { desc = "[T]oggle [A]erial" })
    vim.keymap.set(
      "n",
      "<leader>sa",
      function() require("aerial").snacks_picker() end,
      { desc = "[S]earch [A]erial Symbols" }
    )
  end,
}
