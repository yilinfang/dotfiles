-- lua/plugins/config/aerial.lua
-- Configuration for `aerial.nvim`

local aerial = require "aerial"
local opts = {
  backends = { "lsp", "treesitter", "markdown", "man" },
  layout = {
    max_width = { 80, 0.4 },
    width = 40,
    min_width = 10,
    win_opts = {
      signcolumn = "yes",
    },
    resize_to_content = false,
    preserve_equality = true,
  },
  show_guides = true,
  guides = {
    mid_item = "├╴",
    last_item = "└╴",
    nested_top = "│ ",
    whitespace = "  ",
  },
}
aerial.setup(opts)

vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>", { desc = "Toggle [A]erial" })
