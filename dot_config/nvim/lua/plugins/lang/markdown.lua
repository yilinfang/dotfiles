return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = true,
    optional = true,
    opts = function(_, opts)
      local list_helper = require "utils.list_helper"
      opts.ensure_installed = list_helper.extend_unique(opts.ensure_installed or {}, {
        "marksman",
        "prettier",
        "markdownlint-cli2",
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = function()
      -- Configure Marksman for Markdown
      vim.lsp.config("marksman", {})
    end,
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        markdown = { "prettier" },
        markdown_inline = { "prettier" },
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        markdown = { "markdownlint-cli2" },
      },
    },
  },

  {
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
  },
}
