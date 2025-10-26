-- lua/bootstrap.lua
-- Entry point for lua configuration

-- Load configuration modules
require('config.options')
require('config.keymaps')
require('config.autocmds')
require('config.plugins')
require('config.custom')
require('config.lsp')
