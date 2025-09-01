-- lua/plugins/config/blink.lua
-- Configuration for `blink.cmp`

local blink = require "blink.cmp"
local opts = {
  keymap = {
    preset = "default",
    -- NOTE: Replace <C-Space> with <C-\>
    ["<C-space>"] = false,
    ["<C-\\>"] = { "show", "show_documentation", "hide_documentation" },
  },
  appearance = {
    nerd_font_variant = "normal", -- "normal" or "mono" depending on your font
  },
  completion = {
    list = {
      selection = { preselect = true, auto_insert = false }, -- NOTE: Use `cancel` keymap to close the menu and undo the preview
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
    },
    ghost_text = {
      enabled = false, -- Disable ghost text
    },
  },
  snippets = { preset = "mini_snippets" },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
    providers = {
      path = {
        opts = {
          show_hidden_files_by_default = true, -- Show hidden files (dotfiles) in path completions
        },
      },
    },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
  cmdline = {
    keymap = {
      preset = "cmdline",
      -- NOTE: Replace <C-Space> with <C-\>
      ["<C-space>"] = false,
      ["<C-\\>"] = { "show", "fallback" },
    },
    completion = {
      menu = { auto_show = true },
      ghost_text = {
        enabled = false, -- Disable ghost text
      },
    },
  },
  term = { enabled = true }, -- Disable terminal completion
}
blink.setup(opts)

-- HACK: Override the default LSP capabilities to include `blink.cmp`
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, blink.get_lsp_capabilities({}, false))
vim.lsp.config("*", { capabilities = capabilities })
