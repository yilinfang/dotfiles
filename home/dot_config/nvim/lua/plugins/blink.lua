-- lua/plugins/blink.lua

return {
  "saghen/blink.cmp",
  opts = {
    completion = {
      list = {
        selection = {
          preselect = false,
          auto_insert = true,
        },
      },
    },
    cmdline = { enabled = false },
  },
}
