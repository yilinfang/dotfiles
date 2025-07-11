-- lua/plugins/todo-comments.lua
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

    -- Search for todo-comments
    vim.keymap.set("n", "<leader>st", "<cmd>TodoTelescope<CR>", { desc = "[S]earch [T]odos" })

    -- Toggle todo-comments quickfix list
    vim.keymap.set("n", "<leader>tt", "<cmd>TodoQuickFix<CR>", { desc = "[T]oggle [T]odo Comments [Q]uikfix List" })

    -- HACK: Toggle todo-comments highlighting
    local is_highlight_active = true -- Set the initial state to enabled
    vim.keymap.set("n", "<leader>tth", function()
      if is_highlight_active then
        require("todo-comments").disable()
        is_highlight_active = false
      else
        require("todo-comments").enable()
        is_highlight_active = true
      end
    end, { desc = "[T]oggle [T]odo Comments [H]ighlight" })
  end,
}
