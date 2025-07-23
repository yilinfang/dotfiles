-- lua/plugins/config/mini/hipatterns.lua
-- Configuration for mini.hipatterns

local hipatterns_ok, hipatterns = pcall(require, "mini.hipatterns")
if hipatterns_ok then
  hipatterns.setup {
    highlighters = {
      -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
      fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
      hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
      todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
      note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
      -- Highlight hex color strings (`#rrggbb`) using that color
      --  mini.extra is needed
      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  }
else
  vim.notify("mini.hipatterns not found", vim.log.levels.WARN)
end
