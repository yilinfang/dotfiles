-- lua/config/mini-completion.lua
-- Configuration for `mini.completion`

local completion = require('mini.completion')
local process_items_opts = {
  kind_priority = {
    -- NOTE: Do not show `Text` items since they are usually noisy,
    --  Use <C-n> / <C-p> to navigate through them if needed
    Text = -1,
    -- Show `Snippet` items at last
    Snippet = 99,
  },
}
local process_items = function(items, base)
  return completion.default_process_items(items, base, process_items_opts)
end
local opts = {
  fallback_action = '',
  mappings = {
    force_twostep = '<C-\\>',
    force_fallback = '',
  },
  -- HACK: Set `omnifunc` instead of `completefunc` for LSP completion
  lsp_completion = {
    source_func = 'omnifunc',
    auto_setup = false,
    process_items = process_items,
  },
}
completion.setup(opts)

-- HACK: Set `omnifunc` for LSP completion only when needed
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('MiniCompletionLspAttach', { clear = true }),
  pattern = nil,
  callback = function(ev) vim.bo[ev.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp' end,
  desc = 'Set omnifunc for mini.completion LSP completion',
})

-- HACK: Override the default LSP capabilities to include `mini.completion`
-- Source: https://github.com/echasnovski/mini.completion/blob/7254cce7766f330170318c8bd4826ec3a3aac183/doc/mini-completion.txt#L434
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, completion.get_lsp_capabilities())
vim.lsp.config('*', { capabilities = capabilities })
