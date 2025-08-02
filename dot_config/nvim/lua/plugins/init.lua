-- lua/plugins/init.lua
-- Load all plugins and their configurations

require "plugins.config.everforest" -- Load colorscheme everforest first
require "plugins.config.treesitter" -- Load treesitter configuration
require "plugins.config.lspconfig" -- Load LSP configuration
require "plugins.config.lsps" -- Load specific LSP configurations
require "plugins.config.lint" -- Load linting configuration
require "plugins.config.conform" -- Load Conform configuration
require "plugins.config.lazydev" -- Load lazydev configuration
require "plugins.config.mini" -- Load mini.nvim configuration
require "plugins.config.copilot" -- Load copilot configuration

require "plugins.custom" -- Load custom plugin configurations
