-- lua/config/mini-pick.lua
-- Configuration for mini.pick
-- NOTE: `mini.extra` is needed
-- NOTE: Deprecated

local pick = require('mini.pick')
pick.setup({})
-- NOTE: No need to set `vim.ui.select` here, as `mini.pick` will do it automatically when loaded
-- vim.ui.select = pick.ui_select -- Use mini.pick as the default UI for vim.ui.select
-- [[ Buitlin pickers ]]
vim.keymap.set('n', '<leader><leader>', '<cmd>Pick buffers<cr>', { desc = "[' '] Search Buffers" })
vim.keymap.set(
  'n',
  '<leader>/',
  "<cmd>Pick buf_lines scope='current'<cr>",
  { desc = '[/] Grep in Current Buffer' }
)
vim.keymap.set('n', '<leader>sh', '<cmd>Pick help<cr>', { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sr', '<cmd>Pick resume<cr>', { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>sd', '<cmd>Pick diagnostic<cr>', { desc = '[S]earch [D]iagnostic' })
vim.keymap.set('n', '<leader>sk', '<cmd>Pick keymaps<cr>', { desc = '[S]earch [K]eymaps' })
vim.keymap.set(
  'n',
  '<leader>st',
  '<cmd>Pick treesitter<cr>',
  { desc = '[S]earch [T]reesitter Nodes' }
)
vim.keymap.set(
  'n',
  '<leader>s.',
  '<cmd>Pick oldfiles<cr>',
  { desc = "[S]earch Old Files (['.'] for repeat)" }
)
vim.keymap.set('n', '<leader>sm', '<cmd>Pick marks<cr>', { desc = '[S]earch [M]arks' })
vim.keymap.set(
  'n',
  '<leader>sj',
  "<cmd>Pick list scope='jump'<cr>",
  { desc = '[S]earch [J]umplist' }
)

-- vim.keymap.set("n", "<leader>sp", "<cmd>Pick hipatterns<cr>", { desc = "[S]earch Hi[p]atterns" }) -- NOTE: Replace with self-written picker
-- [[ LSP pickers ]]
-- NOTE: Only available when LSP is attached
--  It will override some of the default LSP keymaps
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'Configure LSP pickers on attach',
  group = vim.api.nvim_create_augroup('mini-pick-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end
    local unmap = function(keys, mode)
      mode = mode or 'n'
      vim.keymap.del(mode, keys, { buffer = event.buf })
    end
    local extra_ok, extra = pcall(require, 'mini.extra')
    if extra_ok then
      -- Fuzzy find all references under cursor
      unmap('grr')
      map('grr', function() extra.pickers.lsp({ scope = 'references' }) end, '[G]oto [R]eferences')
      -- Jump to the implementation of the word under cursor
      unmap('gri')
      map(
        'gri',
        function() extra.pickers.lsp({ scope = 'implementation' }) end,
        '[G]oto [I]mplementation'
      )
      -- Jump to the definition of the word under cursor
      unmap('grd')
      map('grd', function() extra.pickers.lsp({ scope = 'definition' }) end, '[G]oto [D]efinition')
      -- Jump to the declaration of the word under cursor
      unmap('grD')
      map(
        'grD',
        function() extra.pickers.lsp({ scope = 'declaration' }) end,
        '[G]oto [D]eclaration'
      )
      -- Fuzzy find all the symbols in current document
      unmap('gO')
      map(
        'gO',
        function() extra.pickers.lsp({ scope = 'document_symbol' }) end,
        'Open Document Symbols'
      )
      -- Fuzzy find all the symbols in current workspace
      unmap('gW')
      map(
        'gW',
        function() extra.pickers.lsp({ scope = 'workspace_symbol' }) end,
        'Open Workspace Symbols'
      )
      -- Jump to the type definition of the word under cursor
      unmap('grt')
      map(
        'grt',
        function() extra.pickers.lsp({ scope = 'type_definition' }) end,
        '[G]oto [T]ype Definition'
      )
    else
      vim.notify('mini.extra not found, LSP pickers will not work.', vim.log.levels.WARN)
    end
  end,
})

-- [[ Custom pickers]]
-- Customized pickers for file and grep
-- HACK: By changing the RIPGREP_CONFIG_PATH to use a custom configuration
-- From: https://github.com/echasnovski/mini.nvim/issues/1859#issuecomment-2979332899
-- Helper function to use ripgrep with custom configuration
local function use_ripgrep_with_config(config_path, picker_function)
  local cache_rg_config = vim.uv.os_getenv('RIPGREP_CONFIG_PATH') or ''
  -- Temporarily set the RIPGREP_CONFIG_PATH to the custom config path
  vim.uv.os_setenv('RIPGREP_CONFIG_PATH', config_path)
  picker_function()
  -- Restore the original RIPGREP_CONFIG_PATH
  if cache_rg_config == '' then
    -- If RIPGREP_CONFIG_PATH was not set, remove it to avoid side effects
    vim.uv.os_unsetenv('RIPGREP_CONFIG_PATH')
  else
    vim.uv.os_setenv('RIPGREP_CONFIG_PATH', cache_rg_config)
  end
end

-- HACK: Add customized pickers to the registry
pick.registry.custom_rg_files = function(local_opts, opts)
  local_opts = local_opts or {} -- Ensure local_opts is not nil
  -- Force to use ripgrep with custom config
  local_opts.tool = 'rg'
  use_ripgrep_with_config(
    vim.fn.stdpath('config') .. '/.rg/files',
    function() pick.builtin.files(local_opts, opts) end
  )
end
pick.registry.custom_rg_files_all = function(local_opts, opts)
  local_opts = local_opts or {} -- Ensure local_opts is not nil
  -- Force to use ripgrep with custom config
  local_opts.tool = 'rg'
  use_ripgrep_with_config(
    vim.fn.stdpath('config') .. '/.rg/files_all',
    function() pick.builtin.files(local_opts, opts) end
  )
end
pick.registry.custom_rg_grep = function(local_opts, opts)
  local_opts = local_opts or {} -- Ensure local_opts is not nil
  -- Force to use ripgrep with custom config
  local_opts.tool = 'rg'
  use_ripgrep_with_config(
    vim.fn.stdpath('config') .. '/.rg/grep',
    function() pick.builtin.grep(local_opts, opts) end
  )
end
pick.registry.custom_rg_grep_all = function(local_opts, opts)
  local_opts = local_opts or {} -- Ensure local_opts is not nil
  -- Force to use ripgrep with custom config
  local_opts.tool = 'rg'
  use_ripgrep_with_config(
    vim.fn.stdpath('config') .. '/.rg/grep_all',
    function() pick.builtin.grep(local_opts, opts) end
  )
end
pick.registry.custom_rg_grep_live = function(local_opts, opts)
  local_opts = local_opts or {} -- Ensure local_opts is not nil
  -- Force to use ripgrep with custom config
  local_opts.tool = 'rg'
  use_ripgrep_with_config(
    vim.fn.stdpath('config') .. '/.rg/grep',
    function() pick.builtin.grep_live(local_opts, opts) end
  )
end
pick.registry.custom_rg_grep_live_all = function(local_opts, opts)
  local_opts = local_opts or {} -- Ensure local_opts is not nil
  -- Force to use ripgrep with custom config
  local_opts.tool = 'rg'
  use_ripgrep_with_config(
    vim.fn.stdpath('config') .. '/.rg/grep_all',
    function() pick.builtin.grep_live(local_opts, opts) end
  )
end
-- HACK: Pick registry (available pickers)
-- From: https://github.com/echasnovski/mini.pick/blob/c8f4ff0251ccb8c6a993ee0dee4e06d9c21a4b99/doc/mini-pick.txt#L1218
pick.registry.custom_registry = function()
  local items = vim.tbl_keys(MiniPick.registry)
  table.sort(items)
  local source = { items = items, name = 'Registry', choose = function() end }
  local chosen_picker_name = MiniPick.start({ source = source })
  if chosen_picker_name == nil then return end
  return MiniPick.registry[chosen_picker_name]()
end

-- Setup Keymaps with customized pickers
-- Map <leader>sf to search files
vim.keymap.set('n', '<leader>sf', '<cmd>Pick custom_rg_files<cr>', { desc = '[S]earch [F]iles' })
-- Map <leader>sF to search files (including files ignored by git)
vim.keymap.set(
  'n',
  '<leader>sF',
  '<cmd>Pick custom_rg_files_all<cr>',
  { desc = '[S]earch [F]iles (including ignored files)' }
)
-- Map <leader>sg to search grep
vim.keymap.set(
  'n',
  '<leader>sg',
  '<cmd>Pick custom_rg_grep_live<cr>',
  { desc = '[S]earch by [G]rep' }
)
-- Map <leader>sG to search grep (including files ignored by git)
vim.keymap.set(
  'n',
  '<leader>sG',
  '<cmd>Pick custom_rg_grep_live_all<cr>',
  { desc = '[S]earch by [G]rep (including ignored files)' }
)
-- Map <leader>ss to pick registry
vim.keymap.set('n', '<leader>ss', '<cmd>Pick custom_registry<cr>', { desc = '[S]earch Regi[s]try' })
