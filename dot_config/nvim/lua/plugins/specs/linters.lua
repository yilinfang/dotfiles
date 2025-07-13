-- lua/plugins/specs/linters.lua
-- Install and configure linters

return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters_by_ft = {
      markdown = { "markdownlint-cli2" },
    },
  },
  specs = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "markdownlint-cli2", -- Ensure markdown linter is installed
      },
    },
  },
}
