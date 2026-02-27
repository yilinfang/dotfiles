-- lua/config/fzf.lua
-- Configuration for `fzf-lua`

local fzf = require('fzf-lua')

-- [[ Setup `fzf-lua` ]]
local opts = {
  'default', -- Use default profile
  winopts = {
    backdrop = 100, -- Disable backdrop dimming
    preview = {
      default = 'bat', -- Use `bat` as default previewer
      -- winopts = {
      --   number = false, -- Disbale line numbers in preview window
      -- },
    },
  },
  files = {
    hidden = true,
    follow = false,
    no_ignore = false,
    toggle_ignore_flag = '--no-ignore-vcs', -- Only ignore .gitignore
  },
  grep = {
    RIPGREP_CONFIG_PATH = vim.env.RIPGREP_CONFIG_PATH, -- Use system ripgrep config
    hidden = true,
    follow = false,
    no_ignore = false,
    toggle_ignore_flag = '--no-ignore-vcs', -- Only ignore .gitignore
  },
  complete_path = {
    cmd = vim.env.FZF_CTRL_T_COMMAND or 'fd --hidden --no-ignore-vcs', -- Use fzf's ctrl-t command if set
  },
  previewers = {
    builtin = {
      -- treesitter = { enabled = false }, -- HACK: Disable treesitter since it is buggy
      -- HACK: Disable image previewer
      extensions = nil,
      snacks_image = { enabled = false },
    },
  },
}
fzf.setup(opts)

-- Registration ui select with fzf-lua
-- HACK: Customize the UI select appearance
fzf.register_ui_select(function(ui_select_opts)
  ui_select_opts.prompt = '> '
  local title = 'Select'
  return {
    winopts = {
      title = ' ' .. title .. ' ',
    },
  }
end)

-- HACK: Create an autocmd to redraw the fzf window when the neovim window is resized
vim.api.nvim_create_autocmd('VimResized', {
  desc = 'Redraw fzf window on resize',
  group = vim.api.nvim_create_augroup('fzflua-redraw', { clear = true }),
  pattern = '*',
  callback = function() fzf.redraw() end,
})

-- [[ Keymaps ]]
vim.keymap.set(
  'n',
  '<leader><leader>',
  '<cmd>FzfLua lgrep_curbuf<cr>',
  { desc = 'Grep Current Buffer' }
)
vim.keymap.set('n', '<leader>,', '<cmd>FzfLua buffers<cr>', { desc = 'Open Buffer Manager' })
vim.keymap.set('n', '<leader>.', '<cmd>FzfLua resume<cr>', { desc = "[' '] Resume Last Search" })
vim.keymap.set('n', '<leader>sf', '<cmd>FzfLua files<cr>', { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sg', '<cmd>FzfLua live_grep<cr>', { desc = '[S]earch [G]rep' })
vim.keymap.set(
  'n',
  '<leader>s.',
  '<cmd>FzfLua oldfiles<cr>',
  { desc = "[S]earch Old Files (['.'] for repeat)" }
)
vim.keymap.set('n', '<leader>sm', '<cmd>FzfLua marks<cr>', { desc = '[S]earch [M]arks' })
vim.keymap.set('n', '<leader>sj', '<cmd>FzfLua jumps<cr>', { desc = '[S]earch [J]umplist' })
vim.keymap.set(
  'n',
  '<leader>sp',
  '<cmd>FzfLua builtin<cr>',
  { desc = '[S]earch Builtin [P]ickers' }
)
vim.keymap.set(
  'i',
  '<C-t>',
  [[<cmd>FzfLua complete_path winopts.title="\ Path\ "<cr>]],
  { desc = 'Fuzzy complete path' }
)

-- [[ LSP pickers ]]
-- NOTE: Only available when LSP is attached
--  It will override some of the default LSP keymaps
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'Configure LSP pickers on attach',
  group = vim.api.nvim_create_augroup('fzflua-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end
    map('<leader>sd', '<cmd>FzfLua lsp_document_diagnostics<cr>', '[S]earch [D]iagnostics')
    map(
      '<leader>sD',
      '<cmd>FzfLua lsp_workspace_diagnostics<cr>',
      '[S]earch Workspace [D]iagnostics'
    )
    -- Jump to the references of the word under cursor
    map('grr', '<cmd>FzfLua lsp_references<cr>', '[G]oto [R]eferences')
    -- Jump to the implementation of the word under cursor
    map('gri', '<cmd>FzfLua lsp_implementations<cr>', '[G]oto [I]mplementation')
    -- Jump to the definition of the word under cursor
    map('grd', '<cmd>FzfLua lsp_definitions<cr>', '[G]oto [D]efinition')
    -- Jump to the declaration of the word under cursor
    map('grD', '<cmd>FzfLua lsp_declarations<cr>', '[G]oto [D]eclaration')
    -- Jump to the type definition of the word under cursor
    map('grt', '<cmd>FzfLua lsp_typedefs<cr>', '[G]oto [T]ype Definition')
    -- Fuzzy find All Code Actions
    map('gra', '<cmd>FzfLua lsp_code_actions<cr>', '[G]oto Code [A]ctions')
    -- Fuzzy find all the symbols in current document
    map('gO', '<cmd>FzfLua lsp_document_symbols<cr>', 'Open Document Symbols')
    -- Fuzzy find all the symbols in current workspace
    map('gW', '<cmd>FzfLua lsp_live_workspace_symbols<cr>', 'Open Workspace Symbols')
  end,
})
