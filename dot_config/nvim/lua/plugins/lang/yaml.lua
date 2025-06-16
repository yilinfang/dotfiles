return {
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false, -- last release is way too old
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = true,
    optional = true,
    opts = function(_, opts)
      local list_helper = require "utils.list_helper"
      opts.ensure_installed = list_helper.extend_unique(opts.ensure_installed or {}, {
        "yamlls",
        "prettier",
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = function()
      vim.lsp.config("yamlls", {
        settings = {
          yaml = {
            schemaStore = {
              -- You must disable built-in schemaStore support if you want to use
              -- this plugin and its advanced options like `ignore`.
              enable = false,
              -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
              url = "",
            },
            schemas = require("schemastore").yaml.schemas(),
          },
        },
      })
    end,
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        yaml = { "prettier" },
      },
    },
  },
}
