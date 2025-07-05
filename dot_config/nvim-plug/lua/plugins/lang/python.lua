return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = true,
    optional = true,
    opts = function(_, opts)
      local list_helper = require "utils.list_helper"
      opts.ensure_installed = list_helper.extend_unique(opts.ensure_installed or {}, {
        "pyright",
        "ruff",
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = function()
      -- Configure Pyright
      vim.lsp.config("pyright", {
        settings = {
          pyright = {
            disableOrganizeImports = true, -- Using Ruff's import organizer
          },
          python = {
            analysis = {
              diagnosticMode = "workspace",
            },
          },
        },
      })

      -- Configure Ruff
      vim.lsp.config("ruff", {})

      -- HACK: Disable hover capability from Ruff
      --  This is to avoid conflicts with Pyright's hover capability.
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client == nil then return end
          if client.name == "ruff" then
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
          end
        end,
        desc = "LSP: Disable hover capability from Ruff",
      })
    end,
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        python = { "ruff_format" },
      },
    },
  },
}
