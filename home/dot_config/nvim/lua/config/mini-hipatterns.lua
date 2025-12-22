-- lua/config/mini-hipatterns.lua
-- Configuration for `mini.hipatterns`

local hipatterns = require('mini.hipatterns')
local opts = {
  highlighters = {
    -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
    fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
    hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
    todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
    note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
    -- Highlight hex color strings (`#rrggbb`) using that color
    -- NOTE: `mini.extra` is needed
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
}
hipatterns.setup(opts)

-- Self-written picker for hipatterns
-- vim.keymap.set(
--   "n",
--   "<leader>sp",
--   -- NOTE: Use `MiniPick.registry.custom_rg_grep { pattern = ... }` instead of `<cmd>Pick custom_rg_grep pattern=...<cr>`
--   -- to avoid potential issues with escaping special characters in Lua strings
--   function() MiniPick.registry.custom_rg_grep { pattern = [[\b(FIXME|HACK|TODO|NOTE)\b]] } end,
--   { desc = "[S]earch Hi[p]atterns" }
-- )

-- HACK: Search patterns with `fzf-lua`
vim.keymap.set(
  'n',
  '<leader>sh',
  [[<cmd>FzfLua grep search=\bFIXME|TODO|HACK|NOTE\b no_esc=true winopts.title="\ Hipatterns\ " prompt=">\ "<cr>]],
  { desc = '[S]earch [H]ipatterns' }
)
