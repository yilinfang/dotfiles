-- lua/custom/plugins.lua
-- Load all plugins and their configurations
-- TODO: Replace `mini.deps` with `vim.pack` when it is ready
--
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
-- require('plugins.mini-base16')
-- require('plugins.mini-hues')
-- add({ source = 'rebelot/kanagawa.nvim' })
-- require('plugins.kanagawa')
-- add { source = "bluz71/vim-moonfly-colors" }
-- require "plugins.config.moonfly"
add({ source = 'folke/tokyonight.nvim' })
require('plugins.tokyonight')
-- add({ source = 'sainnhe/sonokai' })
-- require('plugins.sonokai')
-- add({ source = 'sainnhe/edge' })
-- require('plugins.edge')

-- Setup mini.icons before other plugins to ensure icons are available
-- NOTE: There is no need to use `add` for the modules in the `mini.nvim` as they are already added as `mini.nvim`
require('plugins.mini-icons')

-- Setup `mini.extras` before other mini plugins to ensure extra features are available
require('plugins.mini-extra')

-- Setup other useful `mini.nvim` modules
require('plugins.mini-ai')
require('plugins.mini-bufremove')
require('plugins.mini-comment')
require('plugins.mini-files')
require('plugins.mini-hipatterns')
require('plugins.mini-indentscope')
require('plugins.mini-move')
require('plugins.mini-pairs')
require('plugins.mini-splitjoin')
require('plugins.mini-surround')
require('plugins.mini-tabline')
require('plugins.mini-trailspace')

-- Setup `gitsigns.nvim`
add({ source = 'lewis6991/gitsigns.nvim' })
require('plugins.gitsigns')

-- Setup `mini.statusline`
-- NOTE: `gitsigns.nvim` needs ot be setup before `mini.statusline`
require('plugins.mini-statusline')

-- -- Setup `friendly-snippets`
-- -- NOTE: Needed by `mini.snippets`
-- add({ source = 'rafamadriz/friendly-snippets' })

-- Setup `mini.snippets`
require('plugins.mini-snippets')

-- Setup `mini.completion`
require('plugins.mini-completion')

-- -- Setup `blink.cmp`
-- add({
--   source = 'saghen/blink.cmp',
--   checkout = vim.g.BLINK_CMP_VERSION or 'v1.7.0',
-- })
-- require('plugins.blink')

-- -- Setup `neo-tree.nvim`
-- add({
--   source = 'nvim-neo-tree/neo-tree.nvim',
--   checkout = vim.g.NEO_TREE_VERSION or '3.37.3',
--   depends = {
--     'nvim-lua/plenary.nvim',
--     'MunifTanjim/nui.nvim',
--   },
-- })
-- require('plugins.neo-tree')

-- Setup `fzf-lua`
add({ source = 'ibhagwan/fzf-lua' })
require('plugins.fzf')

-- Add `nvim-lspconfig`
-- Useful preset configurations for LSP servers
add({ source = 'neovim/nvim-lspconfig' })

-- Setup `nvim-treesitter`
add({
  source = 'nvim-treesitter/nvim-treesitter',
  -- Use 'master' while monitoring updates in 'main'
  checkout = 'master',
  monitor = 'main',
  -- Perform action after every checkout
  hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
})
require('plugins.treesitter')

-- -- Setup `aerial.nvim`
-- add({ source = 'stevearc/aerial.nvim' })
-- require('plugins.aerial')

-- Setup `nvim-lint`
add({ source = 'mfussenegger/nvim-lint' })
require('plugins.lint')

-- Setup `conform.nvim`
add({ source = 'stevearc/conform.nvim' })
require('plugins.conform')

-- -- Setup `grug-far.nvim`
-- add { source = "MagicDuck/grug-far.nvim" }
-- require "plugins.grug-far"

-- Setup `vim-fugitive`
add({ source = 'tpope/vim-fugitive' })

-- Setup `vim-sleuth`
add({ source = 'tpope/vim-sleuth' })

-- Setup `copilot.vim`
add({ source = 'github/copilot.vim' })
require('plugins.copilot')
