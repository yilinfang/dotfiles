-- lua/plugins/config/mini/indentscope.lua
-- Configuration for `mini.indentscope`

local indentscope = require "mini.indentscope"
local opts = {
  draw = {
    animation = indentscope.gen_animation.none(),
  },
  options = { try_as_border = true },
}
indentscope.setup(opts)

-- HACK: Create an autocmd to disable indentscope in certain filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "aerial",
    "fzf",
    "grug-far",
    "neo-tree",
  },
  group = vim.api.nvim_create_augroup("disable-indentscope-filetype", { clear = true }),
  callback = function() vim.b.miniindentscope_disable = true end,
})
