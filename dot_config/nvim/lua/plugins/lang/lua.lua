return {
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
    specs = {
      -- HACK: Add `lazydev` to `blink` sources
      --  CODE FROM: https://github.com/AstroNvim/AstroNvim/blob/5adafa02ab066326f911160dd6c73d758407fe46/lua/astronvim/plugins/lazydev.lua#L17
      {
        "Saghen/blink.cmp",
        optional = true,
        opts = {
          sources = {
            default = { "lazydev" },
            providers = {
              lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
            },
          },
        },
      },
    },
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = true,
    optional = true,
    opts = function(_, opts)
      local list_helper = require "utils.list_helper"
      opts.ensure_installed = list_helper.extend_unique(opts.ensure_installed or {}, {
        "lua_ls",
        "stylua",
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = function(_, opts)
      -- Configure Lua LSP for Neovim config, runtime and plugins
      vim.lsp.config("lua_ls", {
        -- cmd = { ... },
        -- filetypes = { ... },
        -- capabilities = {},
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
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
        lua = { "stylua" },
      },
    },
  },
}
