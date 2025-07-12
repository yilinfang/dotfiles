-- lua/plugins/mini.lua
-- Mini.nvim: Collection of various small independent plugins/modules

return {
  "echasnovski/mini.nvim",
  config = function()
    -- Better Around/Inside textobjects
    require("mini.ai").setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    require("mini.surround").setup()

    -- HACK: Other Mini modules
    require("mini.comment").setup()
    require("mini.files").setup()
    vim.keymap.set("n", "<leader>e", "<cmd>lua MiniFiles.open()<cr>", { desc = "Open File [E]xplorer" })
    require("mini.move").setup()
    require("mini.pairs").setup()
    require("mini.statusline").setup()
  end,
}
