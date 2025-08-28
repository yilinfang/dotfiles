-- lua/plugins/init.lua
-- Load all plugins and their configurations
-- TODO: Lazy loading plugins

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
local add, now = minideps.add, minideps.now

-- [[ Add plugins ]]
now(function() add { source = "stevearc/conform.nvim" } end)
now(function() add { source = "github/copilot.vim" } end)
now(function() add { source = "rafamadriz/friendly-snippets" } end)
now(function() add { source = "ibhagwan/fzf-lua" } end)
now(function() add { source = "lewis6991/gitsigns.nvim" } end)
now(function() add { source = "neovim/nvim-lspconfig" } end)
now(function()
  add {
    source = "nvim-treesitter/nvim-treesitter",
    -- Use 'master' while monitoring updates in 'main'
    checkout = "master",
    monitor = "main",
    -- Perform action after every checkout
    hooks = { post_checkout = function() vim.cmd "TSUpdate" end },
  }
end)
now(function() add { source = "tpope/vim-fugitive" } end)
now(function() add { source = "bluz71/vim-moonfly-colors" } end)
now(function() add { source = "tpope/vim-sleuth" } end)

-- [[ Setup plugins ]]
-- NOTE: Be careful with the order of setting up plugins!!!

-- Setup colorscheme in the very beginning
now(function() require "plugins.config.moonfly" end)

-- Setup mini.icons before other plugins to ensure icons are available
now(function() require "plugins.config.mini.icons" end)

-- Setup `mini.extras` before other mini plugins to ensure extra features are available
now(function() require "plugins.config.mini.extra" end)

-- Setup `mini.keymap` before other mini plugins to ensure keymaps are set
now(function() require "plugins.config.mini.keymap" end)

-- Setup some useful `mini.nvim` modules
now(function() require "plugins.config.mini.ai" end)
now(function() require "plugins.config.mini.comment" end)
now(function() require "plugins.config.mini.files" end)
now(function() require "plugins.config.mini.hipatterns" end)
now(function() require "plugins.config.mini.indentscope" end)
now(function() require "plugins.config.mini.move" end)
now(function() require "plugins.config.mini.pairs" end)
now(function() require "plugins.config.mini.surround" end)
now(function() require "plugins.config.mini.tabline" end)
now(function() require "plugins.config.mini.trailspace" end)

-- Setup `gitsigns.nvim`
now(function() require "plugins.config.gitsigns" end)

-- Setup `mini.statusline`
-- NOTE: `mini.icons` and `gitsigns` must be loaded before `mini.statusline`
now(function() require "plugins.config.mini.statusline" end)

-- Setup `nvim-treesitter`
now(function() require "plugins.config.treesitter" end)

-- Setup and configure LSP
now(function() require "plugins.config.lspconfig" end)

-- Setup `confrom.nvim`
now(function() require "plugins.config.conform" end)

-- Setup `copilot.vim`
now(function() require "plugins.config.copilot" end)

-- Setup `mini.snippets`
-- NOTE: `friendly-snippets` is needed
now(function() require "plugins.config.mini.snippets" end)

-- Setup `mini.completion`
-- NOTE: `mini.snippets` needs to be loaded before `mini.completion`
now(function() require "plugins.config.mini.completion" end)

-- Setup `fzf-lua`
now(function() require "plugins.config.fzf" end)

-- Setup custom plugins
now(function() require "plugins.custom" end)
