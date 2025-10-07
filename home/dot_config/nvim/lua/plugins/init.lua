-- lua/plugins/init.lua
-- Load all plugins and their configurations
-- TODO: Replace `mini.deps` with `vim.pack` when it is ready

-- [[ Install `mini.deps` with `mini.nvim` ]]
-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath "data" .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not (vim.uv or vim.loop).fs_stat(mini_path) then
  vim.cmd 'echo "Installing `mini.nvim`" | redraw'
  local clone_cmd = {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/nvim-mini/mini.nvim",
    mini_path,
  }
  vim.fn.system(clone_cmd)
  vim.cmd "packadd mini.nvim | helptags ALL"
  vim.cmd 'echo "Installed `mini.nvim`" | redraw'
end

local ok, minideps = pcall(require, "mini.deps")
if not ok then
  vim.notify("Failed to load `mini.deps`", vim.log.levels.ERROR)
  return
end

-- Setup `mini.deps` to manage dependencies
minideps.setup { path = { package = path_package } }

-- [[ Setup plugins ]]
-- NOTE: Be careful with the order of setting up plugins!!!
local add = minideps.add

-- Setup colorscheme in the very beginning
add { source = "rebelot/kanagawa.nvim" }
require "plugins.config.kanagawa"
-- add { source = "bluz71/vim-moonfly-colors" }
-- require "plugins.config.moonfly"

-- Setup mini.icons before other plugins to ensure icons are available
-- NOTE: There is no need to use `add` for the modules in the `mini.nvim` as they are already added as `mini.nvim`
require "plugins.config.mini.icons"

-- Setup `mini.extras` before other mini plugins to ensure extra features are available
require "plugins.config.mini.extra"

-- Setup other useful `mini.nvim` modules
require "plugins.config.mini.ai"
require "plugins.config.mini.comment"
require "plugins.config.mini.files"
require "plugins.config.mini.hipatterns"
require "plugins.config.mini.indentscope"
require "plugins.config.mini.move"
require "plugins.config.mini.pairs"
require "plugins.config.mini.splitjoin"
require "plugins.config.mini.surround"
require "plugins.config.mini.tabline"
require "plugins.config.mini.trailspace"

-- Setup `gitsigns.nvim`
add { source = "lewis6991/gitsigns.nvim" }
require "plugins.config.gitsigns"

-- Setup `mini.statusline`
-- NOTE: `gitsigns.nvim` needs ot be setup before `mini.statusline`
require "plugins.config.mini.statusline"

-- Setup and configure LSP
add { source = "neovim/nvim-lspconfig" }
require "plugins.config.lspconfig"

-- Setup `friendly-snippets`
-- NOTE: Needed by `mini.snippets`
add { source = "rafamadriz/friendly-snippets" }

-- Setup `mini.snippets`
require "plugins.config.mini.snippets"

-- Setup `mini.completion`
require "plugins.config.mini.completion"

-- -- Setup `blink.cmp`
-- add {
--   source = "saghen/blink.cmp",
--   checkout = vim.g.BLINK_CMP_VERSION or "v1.7.0",
-- }
-- require "plugins.config.blink"

-- -- Setup `neo-tree.nvim`
-- add {
--   source = "nvim-neo-tree/neo-tree.nvim",
--   checkout = vim.g.NEO_TREE_VERSION or "3.36.1",
--   depends = {
--     "nvim-lua/plenary.nvim",
--     "MunifTanjim/nui.nvim",
--   },
-- }
-- require "plugins.config.neo-tree"

-- Setup `fzf-lua`
add { source = "ibhagwan/fzf-lua" }
require "plugins.config.fzf"

-- Setup `nvim-treesitter`
add {
  source = "nvim-treesitter/nvim-treesitter",
  -- Use 'master' while monitoring updates in 'main'
  checkout = "master",
  monitor = "main",
  -- Perform action after every checkout
  hooks = { post_checkout = function() vim.cmd "TSUpdate" end },
}
require "plugins.config.treesitter"

-- -- Setup `aerial.nvim`
-- add { source = "stevearc/aerial.nvim" }
-- require "plugins.config.aerial"

-- Setup `nvim-lint`
add { source = "mfussenegger/nvim-lint" }
require "plugins.config.lint"

-- Setup `confrom.nvim`
add { source = "stevearc/conform.nvim" }
require "plugins.config.conform"

-- -- Setup `grug-far.nvim`
-- add { source = "MagicDuck/grug-far.nvim" }
-- require "plugins.config.grug-far"

-- Setup `vim-fugitive`
add { source = "tpope/vim-fugitive" }

-- Setup `vim-sleuth`
add { source = "tpope/vim-sleuth" }

-- Setup `copilot.vim`
add { source = "github/copilot.vim" }
require "plugins.config.copilot"

-- Setup custom plugins
require "plugins.custom"
