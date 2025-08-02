-- lua/plugins/config/copilot.lua
-- Configuration for copilot.vim

local copilot_disabled_filetypes = vim.g.copilot_disabled_filetypes
  or {
    "netrw",
    "tutor",
    "man",
    "qf",
    "", -- Unknown filetype
  }

local copilot_disabled_buftypes = vim.g.copilot_disabled_buftypes
  or {
    "help",
    "nofile",
    "terminal",
    "prompt",
    "quickfix",
    "acwrite",
  }

local function should_enable_copilot()
  local bo = vim.bo
  local ft = bo.filetype
  local bt = bo.buftype
  -- Disable copilot if current buffer is not modifiable
  if not bo.modifiable then return false end
  -- Disable copilot for specific filetypes
  if vim.tbl_contains(copilot_disabled_filetypes, ft) then return false end
  -- Disable copilot for specific buftypes
  if vim.tbl_contains(copilot_disabled_buftypes, bt) then return false end
  -- Enable copilot for all other cases
  return true
end

-- Create an autocmd to eable copilot when entering a buffer
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  group = vim.api.nvim_create_augroup("enable-copilot-buf-enter", { clear = true }),
  callback = function()
    if should_enable_copilot() then
      vim.b.copilot_enabled = true
    else
      vim.b.copilot_enabled = false
    end
  end,
})

-- [[ Key Mappings ]]
vim.keymap.set("i", "<M-y>", 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
})
vim.g.copilot_no_tab_map = true -- NOTE: Disable default tab mapping
vim.keymap.set("i", "<M-d>", "<Plug>(copilot-dismiss)")
vim.keymap.set("i", "<M-n>", "<Plug>(copilot-next)")
vim.keymap.set("i", "<M-p>", "<Plug>(copilot-previous)")
vim.keymap.set("i", "<M-.>", "<Plug>(copilot-suggest)")
vim.keymap.set("i", "<M-w>", "<Plug>(copilot-accept-word)")
vim.keymap.set("i", "<M-l>", "<Plug>(copilot-accept-line)")

-- HACK: Map <leader>tc to toggle copilot
vim.keymap.set("n", "<leader>tc", function()
  vim.b.copilot_enabled = not vim.b.copilot_enabled
  if vim.b.copilot_enabled then
    vim.notify("Copilot enabled", vim.log.levels.INFO)
  else
    vim.notify("Copilot disabled", vim.log.levels.INFO)
  end
end, { desc = "Toggle Copilot" })
