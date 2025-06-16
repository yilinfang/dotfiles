-- Useful plugin to show you pending keybinds.
return {
  "folke/which-key.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- HACK: nvim-web-devicons for which-key.nvim
  event = "VeryLazy", -- HACK: Set the event of which-key.nvim to VeryLazy
  opts = {
    -- delay between pressing a key and opening which-key (milliseconds)
    -- this setting is independent of vim.opt.timeoutlen
    delay = 0,
    icons = {
      -- set icon mappings to true if you have a Nerd Font
      mappings = true,
      -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
      -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
      keys = {},
    },

    -- Document existing key chains
    spec = {
      { "<leader>s", group = "[S]earch" },
      { "<leader>t", group = "[T]oggle" },
      { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
    },

    -- HACK: Change which-key peset
    preset = "helix",
  },
}
