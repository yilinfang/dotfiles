-- [[ Basic Autocommands ]]
-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- HACK: Check for spell and wrap in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  desc = "Check for spell in text filetypes",
  group = vim.api.nvim_create_augroup("kickstart-spell-check", { clear = true }),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.wrap = true
  end,
})

-- HACK: Automatically resize splits when the window is resize
--  It will resize all splits to have equal height and width,
--  but not preserve the current size of splits.
vim.api.nvim_create_autocmd("VimResized", {
  desc = "Automatically resize splits when the window is resized",
  group = vim.api.nvim_create_augroup("kickstart-resize-splits", { clear = true }),
  command = "windo wincmd = ",
})
