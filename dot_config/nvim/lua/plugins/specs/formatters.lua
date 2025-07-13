-- lua/plugins/specs/formatters.lua
-- Install and configure formatters

return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_format" },
        sh = { "shfmt" },
        fish = { "fish_indent" },
        markdown = { "prettier" },
        toml = { "taplo" },
        json = { "prettier" },
        yaml = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        javascript = { "prettier" },
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      local list_helper = require "utils.list_helper"
      opts.ensure_installed = list_helper.extend_unique(opts.ensure_installed, {
        "stylua",
        "ruff",
        "shfmt",
        "prettier",
        "taplo",
      })
    end,
  },
}
