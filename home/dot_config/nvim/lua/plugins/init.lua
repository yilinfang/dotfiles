-- lua/plugins/init.lua
-- Load all plugins and their configurations

-- TODO: Replace `mini.deps` with `vim.pack` when it becomes stable
-- Install `mini.deps`
-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath "data" .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not (vim.uv or vim.loop).fs_stat(mini_path) then
  vim.cmd 'echo "Installing `mini.nvim`" | redraw'
  local clone_cmd = {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/echasnovski/mini.nvim",
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
local add, now = minideps.add, minideps.now

-- [[ Add plugins ]]
add { source = "stevearc/conform.nvim" }
add { source = "github/copilot.vim" }
add { source = "sainnhe/everforest" }
add { source = "rafamadriz/friendly-snippets" } -- Required by `mini.snippets` and `mini.completion`
add { source = "lewis6991/gitsigns.nvim" }
add { source = "folke/lazydev.nvim" }
add { source = "mfussenegger/nvim-lint" }
add { source = "neovim/nvim-lspconfig" }
add {
  source = "nvim-treesitter/nvim-treesitter",
  -- Use 'master' while monitoring updates in 'main'
  checkout = "master",
  monitor = "main",
  -- Perform action after every checkout
  hooks = { post_checkout = function() vim.cmd "TSUpdate" end },
}
add { source = "tpope/vim-fugitive" }
add { source = "tpope/vim-sleuth" }

-- [[ Configure and setup plugins ]]
-- NOTE: Be careful with the order of setting up plugins!!!

-- Setup colorscheme everforest first
now(function() require "plugins.config.everforest" end)

-- Setup mini.icons before other plugins to ensure icons are available
now(function() require "plugins.config.mini.icons" end)

-- Setup mini.extras before other mini plugins to ensure extra features are available
now(function() require "plugins.config.mini.extra" end)

-- Setup mini.keymap before other mini plugins to ensure keymaps are set
now(function() require "plugins.config.mini.keymap" end)

-- Setup some useful mini plugins
now(function() require "plugins.config.mini.ai" end)
now(function() require "plugins.config.mini.comment" end)
now(function() require "plugins.config.mini.files" end)
now(function() require "plugins.config.mini.hipatterns" end)
now(function() require "plugins.config.mini.move" end)
now(function() require "plugins.config.mini.pairs" end)
now(function() require "plugins.config.mini.surround" end)
now(function() require "plugins.config.mini.tabline" end)
now(function() require "plugins.config.mini.trailspace" end)

-- Setup gitsigns
now(function() require "plugins.config.gitsigns" end)

-- Setup mini.statusline
-- NOTE: `mini.icons` and `gitsigns` must be loaded before `mini.statusline`
now(function() require "plugins.config.mini.statusline" end)

-- Setup nvim-treesitter
now(function() require "plugins.config.treesitter" end)

-- Setup configure lsp
now(function()
  require "plugins.config.lspconfig"
  require "plugins.config.lsps" -- Load configurations for specify LSPs
end)

-- Setup lazydev
now(function() require "plugins.config.lazydev" end)

-- Setup nvim-lint
now(function() require "plugins.config.lint" end)

-- Setup confrom
now(function() require "plugins.config.conform" end)

-- Setup mini.snippets
-- NOTE: Required by `mini.completion`
now(function() require "plugins.config.mini.snippets" end)

-- Setup mini.completion
now(function() require "plugins.config.mini.completion" end)

-- Setup copilot.vim
now(function() require "plugins.config.copilot" end)

-- Setup mini.pick
-- NOTE: Put `mini.pick` at the end since it will override some keymaps
now(function() require "plugins.config.mini.pick" end)

-- Setup custom plugins
now(function() require "plugins.custom" end)
