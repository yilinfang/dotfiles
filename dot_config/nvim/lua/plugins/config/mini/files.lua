-- lua/plugins/config/mini/files.lua
-- Configuration for mini.files

local files_ok, files = pcall(require, "mini.files")
if files_ok then
  files.setup {}
  -- Map <leader>e to open mini.files
  vim.keymap.set("n", "<leader>e", "<cmd>lua MiniFiles.open()<cr>", { desc = "Open mini.files [E]xplorer" })
else
  vim.notify("mini.files not found", vim.log.levels.WARN)
end
