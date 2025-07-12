-- lua/plugins/guess-indent.lua
-- Detect tabstop and shiftwidth automatically

return {
  "NMAC427/guess-indent.nvim",
  event = { "BufReadPost", "BufNewFile" }, -- HACK: Set the event of guess-indent.nvim to BufReadPost, BufNewFile
  config = function()
    require("guess-indent").setup {}
    vim.keymap.set("n", "<leader>g", "<cmd>GuessIndent<CR>", { desc = "[G]uess Indent" })
  end,
}
