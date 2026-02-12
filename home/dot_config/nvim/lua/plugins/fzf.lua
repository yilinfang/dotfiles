-- lua/plugins/fzf.lua

return {
  "ibhagwan/fzf-lua",
  keys = {
    {
      "<C-t>",
      function()
        FzfLua.complete_path()
      end,
      mode = "i",
    },
  },
}
