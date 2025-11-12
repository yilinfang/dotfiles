-- after/lsp/pyright.lua
-- Configuration for `pyright`
-- NOTE: `nvim-lspconfig` is needed

-- HACK: Disable hover capability from `Ruff`
--  This is to avoid conflicts with `Pyright`'s hover capability.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then return end
    if client.name == 'ruff' then
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = 'LSP: Disable hover capability from Ruff',
})

local M = {
  settings = {
    pyright = {
      disableOrganizeImports = true, -- Using `Ruff`'s import organizer
    },
    python = {
      analysis = {
        diagnosticMode = 'workspace',
      },
    },
  },
}

-- HACK: Disable `pyright`'s analysis if `mypy` is available
if vim.fn.executable('mypy') == 1 then M.settings.python.analysis.ignore = { '*' } end

return M
