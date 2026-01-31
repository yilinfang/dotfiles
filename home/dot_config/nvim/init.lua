--[[

Yilin Fang's Personal Neovim Configuration
A miminal setup based on `mini.nvim` (https://github.com/nvim-mini/mini.nvim)
Copyright (c) 2025 Yilin Fang

Very thanks to:
  - `AstroNvim` (https://astronvim.com/)
  - `Kickstart.nvim` (https://github.com/nvim-lua/kickstart.nvim)
  - `LazyVim` (https://www.lazyvim.org/)
  - `MiniMax` (https://github.com/nvim-mini/MiniMax)

--]]

-- OPTIONS {{{

-- Leadey key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable some providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- Clipboard
if vim.env.SSH_TTY then
  vim.g.clipboard = {
    name = 'Customized OSC 52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
      ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    paste = {
      ['+'] = function()
        local content = vim.fn.getreg('')
        return vim.split(content, '\n')
      end,
      ['*'] = function()
        local content = vim.fn.getreg('')
        return vim.split(content, '\n')
      end,
    },
  }
end

-- General options
vim.o.autoread = true
vim.o.breakindent = true
vim.o.confirm = true
vim.o.cursorline = true
vim.o.cursorlineopt = 'screenline,number'
vim.o.fillchars = 'fold:╌'
vim.o.ignorecase = true
vim.o.inccommand = 'split'
vim.o.linebreak = true
vim.o.mouse = 'a'
vim.o.number = true
vim.o.relativenumber = false
vim.o.scrolloff = 8
vim.o.showmode = false
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.termguicolors = true
vim.o.timeoutlen = 300
vim.o.undofile = true
vim.o.updatetime = 250
vim.o.wrap = false

-- Built-in completion
vim.o.complete = '.,w,b,kspell' -- Use less sources
vim.o.completeopt = 'menuone,noselect,fuzzy,nosort' -- Use custom behavior

-- List chars
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Indentation
vim.o.autoindent = true
vim.o.copyindent = true
vim.o.expandtab = false
vim.o.preserveindent = true
vim.o.shiftround = true
vim.o.shiftwidth = 8
vim.o.smartindent = true
vim.o.softtabstop = 8
vim.o.tabstop = 8

-- Fold
vim.o.foldmethod = 'manual' -- Use manual fold method by default
vim.o.foldlevel = 99 -- Open all folds by default
vim.o.foldtext = '' -- Use default fold text

-- }}}

-- KEYMAPS {{{

-- vim.keymap.set('i', '<C-[>', '<Esc>', { desc = 'Exit insert mode' })
-- vim.keymap.set('n', '<C-q>', '<C-v>', { desc = 'Enter visual block mode' })
vim.keymap.set('n', '<leader>/', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlighting' })
-- vim.keymap.set('n', '<leader>d', '<cmd>bdelete<CR>', { desc = 'Delete current buffer' })
vim.keymap.set(
  'n',
  '<leader>x',
  vim.diagnostic.setloclist,
  { desc = 'Open Diagnostic Quickfi[x] List' }
)
-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', 'gt', '<cmd>bnext<cr>', { desc = 'Go to next buffer' })
vim.keymap.set('n', 'gT', '<cmd>bprevious<cr>', { desc = 'Go to previous buffer' })
vim.keymap.set(
  'n',
  '<leader>f',
  function() vim.fn.setreg('+', vim.fn.expand('%:p')) end,
  { desc = 'Copy file path to system clipboard' }
)
vim.keymap.set(
  'n',
  '<leader>y',
  '<cmd>%y+<cr>',
  { desc = 'Yank entire buffer to system clipboard' }
)
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Yank selection to system clipboard' })
vim.keymap.set('n', '<leader>ts', function()
  vim.opt_local.spell = not vim.opt_local.spell:get()
  local status = vim.opt_local.spell:get() and 'ON' or 'OFF'
  print('Spell check: ' .. status)
end, { desc = '[T]oggle [S]pell Check' })
vim.keymap.set('n', '<leader>tw', function()
  vim.opt_local.wrap = not vim.opt_local.wrap:get()
  local status = vim.opt_local.wrap:get() and 'ON' or 'OFF'
  print('Wrap: ' .. status)
end, { desc = '[T]oggle [W]rap' })

-- HACK: Better up/down
--  From LazyVim: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
vim.keymap.set(
  { 'n', 'x' },
  'j',
  "v:count == 0 ? 'gj' : 'j'",
  { desc = 'Down', expr = true, silent = true }
)
vim.keymap.set(
  { 'n', 'x' },
  'k',
  "v:count == 0 ? 'gk' : 'k'",
  { desc = 'Up', expr = true, silent = true }
)

-- }}}

-- AUTOCMDS {{{

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- Check for spell and wrap in text filetypes
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Check for spell in text filetypes',
  group = vim.api.nvim_create_augroup('spell-check-on-text', { clear = true }),
  pattern = { 'text', 'plaintex', 'typst', 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.wrap = true
  end,
})

-- Automatically enable wrap for quickfix window
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Enable wrap for quickfix window',
  group = vim.api.nvim_create_augroup('quickfix-wrap', { clear = true }),
  pattern = 'qf',
  callback = function() vim.opt_local.wrap = true end,
})

-- HACK: Automatically resize splits when the window is resize
--  It will resize all splits to have equal height and width,
--  but not preserve the current size of splits.
vim.api.nvim_create_autocmd('VimResized', {
  desc = 'Automatically resize splits when the window is resized',
  group = vim.api.nvim_create_augroup('resize-splits', { clear = true }),
  command = 'windo wincmd = ',
})

-- }}}

-- LSP CONFIGURATIONS {{{

-- [[ Diagnostic ]]
-- Modified from (Thanks echasnovski!): https://github.com/nvim-mini/MiniMax/blob/main/configs/nvim-0.11/plugin/10_options.lua
local diagnostic_opts = {
  -- Define how diagnostic entries should be shown
  signs = false, -- NOTE: Disable signs like vscode
  underline = { severity = { min = 'HINT', max = 'ERROR' } },
  virtual_lines = false, -- Disable virtual_lines
  virtual_text = {
    severity = { min = 'ERROR', max = 'ERROR' },
  },

  -- Don't update diagnostics when typing
  update_in_insert = false,
}
vim.diagnostic.config(diagnostic_opts)

-- [[ Keymappings ]]
-- Modifiled from kickstart.nvim (https://github.com/nvim-lua/kickstart.nvim/blob/3338d3920620861f8313a2745fd5d2be39f39534/init.lua#L495)
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'Configure LSP settings on attach',
  group = vim.api.nvim_create_augroup('lspconfig-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- Rename the variable under your cursor.
    --  Most Language Servers support renaming across files, etc.
    map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

    -- Execute a code action, usually your cursor needs to be on top of an error
    -- or a suggestion from your LSP for this to activate.
    map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

    -- Find references for the word under your cursor.
    map('grr', vim.lsp.buf.references, '[G]oto [R]eferences')

    -- Jump to the implementation of the word under your cursor.
    --  Useful when your language has ways of declaring types without an actual implementation.
    map('gri', vim.lsp.buf.implementation, '[G]oto [I]mplementation')

    -- Jump to the definition of the word under your cursor.
    --  This is where a variable was first declared, or where a function is defined, etc.
    --  To jump back, press <C-t>.
    map('grd', vim.lsp.buf.definition, '[G]oto [D]efinition')

    -- WARN: This is not Goto Definition, this is Goto Declaration.
    --  For example, in C this would take you to the header.
    map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    -- Fuzzy find all the symbols in your current document.
    --  Symbols are things like variables, functions, types, etc.
    map('gO', vim.lsp.buf.document_symbol, 'Open Document Symbols')

    -- Fuzzy find all the symbols in your current workspace.
    --  Similar to document symbols, except searches over your entire project.
    map('gW', vim.lsp.buf.workspace_symbol, 'Open Workspace Symbols')

    -- Jump to the type of the word under your cursor.
    --  Useful when you're not sure what type a variable is and you want to see
    --  the definition of its *type*, not where it was *defined*.
    map('grt', vim.lsp.buf.type_definition, '[G]oto [T]ype Definition')

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if
      client
      and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
    then
      local highlight_augroup =
        vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({
            group = 'kickstart-lsp-highlight',
            buffer = event2.buf,
          })
        end,
      })
    end

    -- The following code creates a keymap to toggle inlay hints in your
    -- code, if the language server you are using supports them
    --
    -- This may be unwanted, since they displace some of your code
    if
      client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
    then
      map(
        '<leader>th',
        function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
        end,
        '[T]oggle Inlay [H]ints'
      )
    end
  end,
})

-- [[ Setup LSPs ]]
-- NOTE: The configurations of LSPs are located in `after/lsp/`
-- Put the configuration in the `after/lsp` instead of `lsp`
-- to make sure they overrides the settings from `nvim-lspconfig`

-- If `lua-language-server` is installed, enable it
if vim.fn.executable('lua-language-server') == 1 then vim.lsp.enable('lua_ls') end

-- If `ruff` is installed, enable it
if vim.fn.executable('ruff') == 1 then vim.lsp.enable('ruff') end

-- If `pyright` is installed, enable it
if vim.fn.executable('pyright') == 1 then vim.lsp.enable('pyright') end

-- if `bash-language-server` is installed, enable it
if vim.fn.executable('bash-language-server') == 1 then vim.lsp.enable('bashls') end

-- }}}

-- BOOTSTRAP & SETUP PLUGINS {{{

-- TODO: Replace `mini.deps` with `vim.pack` when it is ready
-- [[ Install `mini.deps` with `mini.nvim` ]]
-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not (vim.uv or vim.loop).fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/nvim-mini/mini.nvim',
    mini_path,
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

local ok, minideps = pcall(require, 'mini.deps')
if not ok then
  vim.notify('Failed to load `mini.deps`', vim.log.levels.ERROR)
  return
end

-- Setup `mini.deps` to manage dependencies
minideps.setup({ path = { package = path_package } })

-- [[ Setup plugins ]]
-- NOTE: Be careful with the order of setting up plugins!!!
local add = minideps.add

-- Setup colorscheme in the very beginning
-- require('config.mini-base16')
-- require('config.mini-hues')
-- add({ source = 'rebelot/kanagawa.nvim' })
-- require('config.kanagawa')
-- add({ source = "bluz71/vim-moonfly-colors" })
-- require("config.moonfly")
-- add({ source = 'folke/tokyonight.nvim' })
-- require('config.tokyonight')
-- add({ source = 'sainnhe/edge' })
-- require('config.edge')
-- add({ source = "sainnhe/sonokai" })
-- require("config.sonokai")
add({ source = 'EdenEast/nightfox.nvim' })
require('config.carbonfox')

-- Setup mini.icons before other plugins to ensure icons are available
-- NOTE: There is no need to use `add` for the modules in the `mini.nvim` as they are already added as `mini.nvim`
require('config.mini-icons')

-- Setup `mini.extras` before other mini plugins to ensure extra features are available
require('config.mini-extra')

-- Setup other useful `mini.nvim` modules
require('config.mini-ai')
require('config.mini-bufremove')
require('config.mini-comment')
require('config.mini-files')
require('config.mini-hipatterns')
require('config.mini-indentscope')
require('config.mini-move')
require('config.mini-pairs')
require('config.mini-splitjoin')
require('config.mini-surround')
require('config.mini-tabline')
require('config.mini-trailspace')

-- Setup `gitsigns.nvim`
add({ source = 'lewis6991/gitsigns.nvim' })
require('config.gitsigns')

-- Setup `mini.statusline`
-- NOTE: `gitsigns.nvim` needs ot be setup before `mini.statusline`
require('config.mini-statusline')

-- -- Setup `friendly-snippets`
-- -- NOTE: Needed by `mini.snippets`
-- add({ source = 'rafamadriz/friendly-snippets' })

-- Setup `mini.snippets`
require('config.mini-snippets')

-- Setup `mini.completion`
require('config.mini-completion')

-- -- Setup `blink.cmp`
-- add({
--   source = 'saghen/blink.cmp',
--   checkout = vim.g.BLINK_CMP_VERSION or 'v1.7.0',
-- })
-- require('config.blink')

-- -- Setup `neo-tree.nvim`
-- add({
--   source = 'nvim-neo-tree/neo-tree.nvim',
--   checkout = vim.g.NEO_TREE_VERSION or '3.37.3',
--   depends = {
--     'nvim-lua/plenary.nvim',
--     'MunifTanjim/nui.nvim',
--   },
-- })
-- require('config.neo-tree')

-- Setup `fzf-lua`
add({ source = 'ibhagwan/fzf-lua' })
require('config.fzf')

-- Add `nvim-lspconfig`
-- Useful preset configurations for LSP servers
add({ source = 'neovim/nvim-lspconfig' })

-- NOTE: Disable treesitter until it is not experienmental in Neovim
-- -- Setup `nvim-treesitter`
-- add({
--   source = 'nvim-treesitter/nvim-treesitter',
--   -- Perform action after every checkout
--   hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
-- })
-- require('config.treesitter')

-- -- Setup `aerial.nvim`
-- add({ source = 'stevearc/aerial.nvim' })
-- require('config.aerial')

-- Setup `nvim-lint`
add({ source = 'mfussenegger/nvim-lint' })
require('config.lint')

-- Setup `conform.nvim`
add({ source = 'stevearc/conform.nvim' })
require('config.conform')

-- -- Setup `grug-far.nvim`
-- add { source = "MagicDuck/grug-far.nvim" }
-- require "config.grug-far"

-- -- Setup `copilot.lua`
-- add({ source = "zbirenbaum/copilot.lua" })
-- require("config.copilot-lua")

-- -- Setup `copilot.vim`
-- add({ source = 'github/copilot.vim' })
-- require('config.copilot')

-- -- Setup `render-markdown.nvim`
-- add({ source = "MeanderingProgrammer/render-markdown.nvim" })
-- require("config.render-markdown")

-- Setup `vim-fugitive`
add({ source = 'tpope/vim-fugitive' })

-- Setup `vim-sleuth`
add({ source = 'tpope/vim-sleuth' })

-- }}}

-- USER MODULES {{{

-- Load my own plugins
require('user.mark-manager').setup()
require('user.statuscolumn').setup()

-- }}}

-- vi:se fdm=marker fmr={{{,}}} fdl=0:
