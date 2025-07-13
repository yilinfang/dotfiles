-- lua/plugins/mason.lua
-- Automatically install LSPs and related tools to stdpath for Neovim
-- Mason must be loaded before its dependents so we need to set it up here.

-- HACK: Make mason.nvim independent of lspconfig
return {
  "mason-org/mason.nvim",
  cmd = {
    "Mason",
    "MasonInstall",
    "MasonUninstall",
    "MasonUninstallAll",
    "MasonLog",
  },
  dependencies = {
    { "WhoIsSethDaniel/mason-tool-installer.nvim", lazy = true, opts_extend = { "ensure_installed" } },
  },
  build = ":MasonUpdate",
  -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
  opts = {},
}
