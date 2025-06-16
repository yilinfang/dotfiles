-- Collection of various small independent plugins/modules
return {
  "echasnovski/mini.nvim",
  config = function()
    -- Better Around/Inside textobjects
    require("mini.ai").setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    require("mini.surround").setup()

    -- HACK: Other Mini modules
    require("mini.comment").setup()
    require("mini.move").setup()
    require("mini.pairs").setup()
  end,
}
