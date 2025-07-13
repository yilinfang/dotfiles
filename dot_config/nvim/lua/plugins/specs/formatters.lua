-- lua/plugins/specs/formatters.lua
-- Install and configure formatters

return {
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
  specs = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        -- "ruff", -- Already installed elsewhere
        -- "shfmt", -- Already installed elsewhere
        "prettier",
        -- "taplo", -- Already installed elsewhere
      },
    },
  },
}
