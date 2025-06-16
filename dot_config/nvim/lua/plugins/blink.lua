-- Autocompletion
return {
  -- Snippet Engine
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    version = "2.*",
    build = (function()
      -- Build Step is needed for regex support in snippets.
      -- This step is not supported in many windows environments.
      -- Remove the below condition to re-enable on windows.
      if vim.fn.has "win32" == 1 or vim.fn.executable "make" == 0 then return end
      return "make install_jsregexp"
    end)(),
    dependencies = {
      -- `friendly-snippets` contains a variety of premade snippets.
      --    See the README about individual language/framework/plugin snippets:
      --    https://github.com/rafamadriz/friendly-snippets
      {
        "rafamadriz/friendly-snippets",
        config = function() require("luasnip.loaders.from_vscode").lazy_load() end,
      },
    },
    opts = {},
    specs = {
      -- HACK: Add LuaSnip snippets for blink.cmp
      { "Saghen/blink.cmp", optional = true, opts = { snippets = { preset = "luasnip" } } },
    },
  },

  {
    "Saghen/blink.cmp",
    event = { "InsertEnter", "CmdlineEnter" }, -- HACK: Load on insert mode or command line enter
    version = "1.*",
    opts_extend = { "sources.default", "cmdline.sources", "term.sources" }, -- HACK: make sources for blink.cmp extendable
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        -- 'default' (recommended) for mappings similar to built-in completions
        preset = "default",
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },

      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 500 }, -- HACK: Show documentation after a delay
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer" }, -- HACK: Default sources for blink.cmp
      },

      -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
      -- which automatically downloads a prebuilt binary when enabled.
      fuzzy = { implementation = "prefer_rust_with_warning" }, -- HACK: Use rust fuzzy matcher for blink.cmp

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },

      -- HACK: Enable blink.cmp in command line mode
      cmdline = {
        keymap = { preset = "inherit" },
        completion = { menu = { auto_show = true } },
      },
    },
  },
}
