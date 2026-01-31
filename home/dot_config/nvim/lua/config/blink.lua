-- lua/config/blink.lua
-- Configuration for `blink.cmp`
-- NOTE: Deprecated but kept for reference

local blink = require('blink.cmp')
local opts = {
  keymap = {
    preset = 'default',
    -- NOTE: Replace <C-Space> with <C-\>
    ['<C-space>'] = false,
    ['<C-\\>'] = { 'show', 'show_documentation', 'hide_documentation' },
  },
  appearance = {
    nerd_font_variant = 'mono', -- "normal" or "mono" depending on your font
  },
  completion = {
    list = {
      selection = { preselect = true, auto_insert = false },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
    },
    ghost_text = {
      enabled = false, -- Disable ghost text
    },
  },
  snippets = {
    preset = 'mini_snippets',
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
    providers = {
      path = {
        opts = {
          -- Show hidden files (dotfiles) in path completions
          show_hidden_files_by_default = true,
        },
      },
    },
  },
  fuzzy = { implementation = 'prefer_rust_with_warning' },
  cmdline = {
    keymap = {
      preset = 'cmdline',
      -- NOTE: Replace <C-Space> with <C-\>
      ['<C-space>'] = false,
      ['<C-\\>'] = { 'show', 'fallback' },
    },
    completion = {
      list = {
        selection = { preselect = false, auto_insert = true },
      },
      menu = { auto_show = true }, -- Auto show menu
      ghost_text = {
        enabled = false, -- Disable ghost text
      },
    },
  },
  term = { enabled = false }, -- Disable terminal completion
}
blink.setup(opts)

-- HACK: Override the default LSP capabilities to include `blink.cmp`
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, blink.get_lsp_capabilities({}, false))
vim.lsp.config('*', { capabilities = capabilities })
