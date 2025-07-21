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
  opts = {
    backends = { "lsp", "treesitter", "markdown", "man" }, -- HACK: Make the LSP default backend
    layout = {
      max_width = { 40, 0.4 }, -- Maximum width of the aerial window
      min_width = { 20, 0.2 }, -- Minimum width of the aerial window
    },
  },
  config = function(_, opts)
    require("aerial").setup(opts)
    vim.keymap.set("n", "<leader>sa", "<cmd>Telescope aerial<CR>", { desc = "[S]earch [A]erial Symbols" })
    vim.keymap.set("n", "<leader>ta", "<cmd>AerialToggle right<CR>", { desc = "[T]oggle [A]erial" })
  end,
}
