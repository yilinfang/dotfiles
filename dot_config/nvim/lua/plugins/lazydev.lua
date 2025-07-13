-- lua/plugins/lazydev.lua
-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
-- used for completion, annotations and signatures of Neovim apis

return {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      -- Load luvit types when the `vim.uv` word is found
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
  specs = {
    -- HACK: Add `lazydev` to `blink` sources
    --  CODE FROM: https://github.com/AstroNvim/AstroNvim/blob/5adafa02ab066326f911160dd6c73d758407fe46/lua/astronvim/plugins/lazydev.lua#L17
    {
      "Saghen/blink.cmp",
      optional = true,
      opts = {
        sources = {
          default = { "lazydev" },
          providers = {
            lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
          },
        },
      },
    },
  },
}
