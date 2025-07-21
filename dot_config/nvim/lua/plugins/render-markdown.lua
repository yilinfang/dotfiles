-- lua/plugins/render-markdown.lua
-- Render Markdown files

if true then return {} end -- Disabled for now

return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
  opts = {
    code = {
      sign = false,
      width = "block",
      left_pad = 2,
      right_pad = 2,
      border = "thick",
    },
    heading = {
      sign = false,
      icons = {},
    },
    completions = {
      lsp = { enabled = true },
    },
  },
  config = function(_, opts)
    require("render-markdown").setup(opts)
    vim.keymap.set(
      "n",
      "<leader>tm",
      function() require("render-markdown").buf_toggle() end,
      { desc = "[T]oggle Render [M]arkdown" }
    )
  end,
}
