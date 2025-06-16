-- HACK: snacks.nvim
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  --@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        header = [[
██╗   ██╗██╗███╗   ███╗███████╗ ██████╗ ██████╗  ██████╗  ██████╗  ██████╗ ██████╗ 
██║   ██║██║████╗ ████║██╔════╝██╔═══██╗██╔══██╗██╔════╝ ██╔═══██╗██╔═══██╗██╔══██╗
██║   ██║██║██╔████╔██║█████╗  ██║   ██║██████╔╝██║  ███╗██║   ██║██║   ██║██║  ██║
╚██╗ ██╔╝██║██║╚██╔╝██║██╔══╝  ██║   ██║██╔══██╗██║   ██║██║   ██║██║   ██║██║  ██║
 ╚████╔╝ ██║██║ ╚═╝ ██║██║     ╚██████╔╝██║  ██║╚██████╔╝╚██████╔╝╚██████╔╝██████╔╝
  ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝      ╚═════╝ ╚═╝  ╚═╝ ╚═════╝  ╚═════╝  ╚═════╝ ╚═════╝ 
          ]],
      },
    },
    explorer = {
      enabled = true,
      replace_netrw = true,
    },
    image = { -- HACK: Forcefully disable image preview in snacks.nvim.
      enabled = false,
      formats = {},
    },
    indent = { enable = true },
    picker = { enabled = true, sources = { explorer = {} } },
    quickfile = { enabled = true, exclude = { "latex" } },
    statuscolumn = { enabled = true },
  },
  keys = {
    -- Keymaps for snacks.explorer
    {
      "<leader>te",
      function() Snacks.explorer.open() end,
      desc = "[T]oggle File [E]xplorer",
    },

    -- Keymaps for snacks.picker
    {
      "<leader>sk",
      function() Snacks.picker.keymaps() end,
      desc = "[S]earch [K]eymaps",
    },
    {
      "<leader>sf",
      function() Snacks.picker.files() end,
      desc = "[S]earch [F]iles",
    },
    {
      "<leader>ss",
      function() Snacks.picker() end,
      desc = "[S]earch [S]elect Picker",
    },
    {
      "<leader>sw",
      function() Snacks.picker.grep_word() end,
      desc = "[S]earch current [W]ord",
    },
    {
      "<leader>sg",
      function() Snacks.picker.grep() end,
      desc = "[S]earch by [G]rep",
    },
    {
      "<leader>sd",
      function() Snacks.picker.diagnostics() end,
      desc = "[S]earch [D]iagnostics",
    },
    {
      "<leader>sr",
      function() Snacks.picker.resume() end,
      desc = "[S]earch [R]esume",
    },
    {
      "<leader>s.",
      function() Snacks.picker.recent() end,
      desc = '[S]earch Recent Files ("." for repeat)',
    },
    {
      "<leader><leader>",
      function() Snacks.picker.buffers() end,
      desc = "[ ] Find existing buffers",
    },
    {
      "<leader>/",
      function() Snacks.picker.lines() end,
      desc = "[/] Fuzzily search in current buffer",
    },
  },
}
