-- plugin/bootstrap.lua
-- Entry point for lua configuration

-- Load configuration modules
require('config.options')
require('config.keymaps')
require('config.autocmds')
require('config.lsp')
require('config.plugins')
require('config.custom')
