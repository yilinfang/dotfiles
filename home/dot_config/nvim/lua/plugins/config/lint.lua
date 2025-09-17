-- lua/plugin/config/lint.lua
-- Configuration for `nvim-lint`

local lint = require "lint"

-- Register linters for various file types
local linters_by_ft = {}
if vim.fn.executable "zsh" == 1 then linters_by_ft.zsh = { "zsh" } end
lint.linters_by_ft = linters_by_ft

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
  callback = function()
    if vim.bo.modifiable then lint.try_lint() end
  end,
})
