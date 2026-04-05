-- after/lsp/basedpyright.lua
-- Configuration for `basedpyright`
-- NOTE: `nvim-lspconfig` is needed

-- HACK: Disable hover capability from `Ruff`
--  This is to avoid conflicts with `basedpyright`'s hover capability.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then return end
    if client.name == 'ruff' then
      -- Disable hover in favor of `basedpyright`
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = 'LSP: Disable hover capability from Ruff',
})

local M = {
  settings = {
    basedpyright = {
      disableOrganizeImports = true, -- Using `Ruff`'s import organizer
      analysis = {
        diagnosticMode = 'workspace',
        -- HACK: Set typeCheckingMode to `off` to match more closely to the Pylance default
        typeCheckingMode = 'off',
      },
    },
  },
}

return M
