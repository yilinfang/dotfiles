-- lua/plugins/custom/lsps.lua
-- Configuration of LSPs
-- NOTE: nvim-lspconfig must be loaeded before this file

-- If lua-language-server is installed, set it up
if vim.fn.executable "lua-language-server" == 1 then
  vim.lsp.config("lua_ls", {
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  })
  vim.lsp.enable "lua_ls"
end

-- If ruff is installed, set it up
if vim.fn.executable "ruff" == 1 then
  vim.lsp.config("ruff", {})
  vim.lsp.enable "ruff"
end

-- If pyright is installed, set it up
if vim.fn.executable "pyright" == 1 then
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
  -- HACK: Disable hover capability from Ruff
  --  This is to avoid conflicts with Pyright's hover capability.
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("disable-ruff-hover-lsp-attach", { clear = true }),
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
end

-- if bash-language-server is installed, set it up
if vim.fn.executable "bash-language-server" == 1 then
  vim.lsp.config("bashls", {})
  vim.lsp.enable "bashls"
end
