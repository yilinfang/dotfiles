-- lua/plugins/lualine.lua
-- Lualine.nvim for statusline

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup {
      options = {
        theme = "solarized-osaka",
        disabled_filetypes = { statusline = { "snacks_dashboard" } },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          { "filename", path = 3 }, -- Aboslute path with tilde
          {
            "diff",
            source = function() -- Use gitsigns.nvim for diff
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        lualine_x = {
          "diagnostics",
          "filetype",
          { "encoding", show_bomb = true },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      extensions = { "lazy", "man", "mason", "quickfix", "oil", "toggleterm" },
      -- Disable some sections
      tabline = {},
      winbar = {},
      inactive_winbar = {},
    }
  end,
}
