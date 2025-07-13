-- lua/plugins/specs/lsps.lua
-- Install and configure LSPs.

return {
  "neovim/nvim-lspconfig",
  optional = true,
  dependencies = {
    { "b0o/SchemaStore.nvim", lazy = true, version = false },
  },
  opts = function(_, opts)
    -- HACK: [[ lua_ls ]]
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
    vim.lsp.enable "lua_ls"
    -- HACK: [[ pyright ]]
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
    vim.lsp.enable "pyright"
    -- HACK: [[ ruff ]]
    vim.lsp.config("ruff", {})
    vim.lsp.enable "ruff"
    -- HACK: Disable hover capability from Ruff
    --  This is to avoid conflicts with Pyright's hover capability.
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("custom_lsp_attach_disable_ruff_hover", { clear = true }),
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
    -- HACK: [[ bashls ]]
    vim.lsp.config("bashls", {})
    vim.lsp.enable "bashls"
    -- HACK: [[ marksman ]]
    vim.lsp.config("marksman", {})
    vim.lsp.enable "marksman"
    -- HACK: [[ taplo ]]
    vim.lsp.config("taplo", {})
    vim.lsp.enable "taplo"
    -- HACK: [[ jsonls ]]
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    vim.lsp.config("jsonls", {
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
      capabilities = capabilities,
    })
    vim.lsp.enable "jsonls"
    -- HACK: [[ yamlls ]]
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
    vim.lsp.enable "yamlls"
  end,
  specs = {
    "whoisSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "pyright",
        "ruff",
        "bash-language-server",
        "shellcheck", -- NOTE: Required for bash-language-server
        "shfmt", -- NOTE: Required for bash-language-server
        "marksman",
        "taplo",
        "json-lsp",
        "yaml-language-server",
      },
    },
  },
}
