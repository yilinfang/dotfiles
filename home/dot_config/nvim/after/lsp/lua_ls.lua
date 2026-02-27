-- after/lsp/lua_ls.lua
-- Configuration for `lua_ls` or `lua-language-server`
-- NOTE: `nvim-lspconfig` is needed

return {
  settings = {
    Lua = {
      completion = {
        callSnippet = 'Replace',
      },
      format = { enable = false }, -- Disable formatting since we use `stylua`
      hint = {
        enable = true,
        arrayIndex = 'Disable',
      },
      runtime = {
        version = 'LuaJIT',
      },
      telemetry = { enable = false },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          '${3rd}/luv/library',
        },
      },
    },
  },
}
