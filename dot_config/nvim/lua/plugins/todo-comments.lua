-- Highlight todo, notes, etc in comments
return {
  "folke/todo-comments.nvim",
  event = { unpack(require("utils.events").LazyFile) }, -- HACK: Set the event of todo-comments to LazyFile
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("todo-comments").setup { signs = false }
    -- Set keymaps
    vim.keymap.set("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next Todo Comment" })

    vim.keymap.set("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous Todo Comment" })

    -- HACK: Custom keymaps for todo-comments
    vim.keymap.set("n", "<leader>st", function() Snacks.picker.todo_comments() end, { desc = "[S]earch [T]odos" })

    -- HACK: Toggle todo-comments highlighting
    local is_highlight_active = true -- Set the initial state to enabled
    vim.keymap.set("n", "<leader>tt", function()
      if is_highlight_active then
        require("todo-comments").disable()
        is_highlight_active = false
      else
        require("todo-comments").enable()
        is_highlight_active = true
      end
    end, { desc = "[T]oggle [T]odo Comments Highlight" })
  end,
}
