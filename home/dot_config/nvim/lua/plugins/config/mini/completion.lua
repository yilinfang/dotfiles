-- lua/plugins/mini/completion.lua
-- Configuration for mini.completion

local completion_ok, completion = pcall(require, "mini.completion")
if completion_ok then
  local opts = {
    fallback_action = "",
    mappings = {
      force_twostep = "<C-\\>",
      force_fallback = "",
    },
  }
  completion.setup(opts)

  -- HACK: Override the default LSP capabilities to include mini.completion
  -- Source: https://github.com/echasnovski/mini.completion/blob/7254cce7766f330170318c8bd4826ec3a3aac183/doc/mini-completion.txt#L434
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend("force", capabilities, completion.get_lsp_capabilities())
  vim.lsp.config("*", { capabilities = capabilities })
else
  vim.notify("mini.completion not found", vim.log.levels.WARN)
end
