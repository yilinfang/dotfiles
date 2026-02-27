-- lua/config/mini-indentscope.lua
-- Configuration for `mini.indentscope`

-- -- HACK: Disable drawing indent guides since we only use the textobjects
-- vim.g.miniindentscope_disable = true

-- -- HACK: Create an autocmd to disable indentscope in certain filetypes
-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = {
--     'fzf',
--     'neo-tree',
--     'minifiles',
--   },
--   group = vim.api.nvim_create_augroup('disable-indentscope-filetype', { clear = true }),
--   callback = function() vim.b.miniindentscope_disable = true end,
-- })

local indentscope = require('mini.indentscope')
local opts = {
  draw = {
    animation = indentscope.gen_animation.none(),
  },
  -- options = { try_as_border = true },
}
indentscope.setup(opts)
