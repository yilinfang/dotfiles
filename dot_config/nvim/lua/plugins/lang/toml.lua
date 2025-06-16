return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = true,
    optional = true,
    opts = function(_, opts)
      local list_helper = require "utils.list_helper"
      opts.ensure_installed = list_helper.extend_unique(opts.ensure_installed or {}, {
        "taplo",
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = function() vim.lsp.config("taplo", {}) end,
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        toml = { "taplo" },
      },
    },
  },
}
