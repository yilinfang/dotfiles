-- lua/plugins/config/grug-far.lua
-- Configuration for `grug-far.nvim`

local grug_far = require "grug-far"
local opts = {}
grug_far.setup(opts)

-- Keymaps for `grug-far.nvim`
vim.keymap.set(
  { "n", "v" },
  "<leader>g",
  function()
    grug_far.open {
      transient = true,
    }
  end,
  { desc = "[G]rug Far" }
)
