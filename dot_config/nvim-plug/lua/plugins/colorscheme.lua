-- HACK: Colorscheme
return {
  "craftzdog/solarized-osaka.nvim",
  lazy = false,
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("solarized-osaka").setup {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    }
    vim.cmd [[colorscheme solarized-osaka]]
  end,
}
