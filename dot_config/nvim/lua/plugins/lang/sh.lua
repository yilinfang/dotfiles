-- lua/plugins/lang/sh.lua

return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = true,
    optional = true,
    opts = function(_, opts)
      local list_helper = require "utils.list_helper"
      opts.ensure_installed = list_helper.extend_unique(opts.ensure_installed or {}, {
        "bash-language-server", -- NOTE: Use mason registry name instead of lspconfig name
        "shfmt",
        "shellcheck",
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = function()
      vim.lsp.config("bashls", {})
      vim.lsp.enable "bashls"
    end,
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        fish = { "fish_indent" },
        sh = { "shfmt" },
      },
    },
  },
}
