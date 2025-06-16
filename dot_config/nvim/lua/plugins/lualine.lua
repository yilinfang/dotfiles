-- HACK: lualine.nvim for statusline
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup {
      options = {
        theme = "solarized-osaka",
        always_show_tabline = false,
        disabled_filetypes = { statusline = { "snacks_dashboard" } },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          { "filename", path = 1 }, -- Relative path
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
      extensions = { "lazy", "mason", "quickfix", "aerial" },
    }
  end,
}
