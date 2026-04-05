-- lua/config/copilot-lua.lua
-- Configuration for `copilot.lua`
-- NOTE: Deprecated but kept for reference

local copilot_disabled_filetypes = vim.g.copilot_disabled_filetypes
  or {
    'fzf',
    'help',
    'netrw',
    'neo-tree',
    'minifiles',
    'tutor',
    'man',
    'qf',
    '', -- Unknown filetype
  }

local copilot_disabled_buftypes = vim.g.copilot_disabled_buftypes
  or {
    'help',
    'nofile',
    'prompt',
    'quickfix',
    'acwrite',
  }

local opts = {
  panel = {
    enabled = false,
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    hide_during_completion = true,
    keymap = {
      accept = '<M-y>',
      accept_word = '<M-w>',
      accept_line = '<M-l>',
      next = '<M-n>',
      prev = '<M-p>',
      dismiss = '<M-d>',
    },
  },
  nes = {
    enabled = false,
  },
  filetypes = {
    -- NOTE: Enabled by default since we are handling disabling via `should_attach`
    ['*'] = true,
  },
  should_attach = function(_, _)
    local bo = vim.bo
    -- Disable copilot if current buffer is not modifiable
    if not bo.modifiable then return false end

    local ft = bo.filetype
    -- Disable copilot for specified filetypes
    if vim.tbl_contains(copilot_disabled_filetypes, ft) then return false end

    local bt = bo.buftype
    -- Disable copilot for specified buftypes
    if vim.tbl_contains(copilot_disabled_buftypes, bt) then return false end

    return true
  end,
}

local copilot = require('copilot')
copilot.setup(opts)

-- Use `<leader>tc` to toggle copilot
vim.keymap.set(
  'n',
  '<leader>tc',
  [[<cmd>Copilot! toggle<CR>]],
  { noremap = true, silent = true, desc = 'Toggle Copilot' }
)
