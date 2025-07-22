-- lua/plugins/neo-tree.lua
-- This module configures Neo-tree, a file explorer for Neovim.

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  lazy = false, -- neo-tree will load itself lazily
  opts = {
    enable_diagnostics = false, -- disable diagnostics in the file explorer
    filesystem = {
      follow_current_file = { enabled = true }, -- follow the current file
      filtered_items = {
        hide_dotfiles = false, -- show dotfiles
        never_show = { -- never show these files
          ".DS_Store",
        },
        never_show_by_pattern = { -- never show files matching these patterns
          ".git",
        },
      },
      hijack_netrw_behavior = "open_current",
    },
    window = {
      mappings = {
        ["<space>"] = "none",
        ["l"] = "open",
        ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = false } },
      },
    },
  },
  keys = {
    { "<leader>te", "<cmd>Neotree toggle reveal<CR>", desc = "[T]oggle Neo Tree File [E]explorer" },
  },
}
