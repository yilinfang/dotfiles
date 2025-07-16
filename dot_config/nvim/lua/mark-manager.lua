-- lua/mark-manager.lua
-- Manage marks in Neovim

local M = {}

-- Delete marks for current buffer
-- Not includes global marks (A-Z)
function M.delete_marks() vim.cmd "delm!" end

-- Delete all marks
-- Includes global marks (A-Z)
function M.delete_all_marks() vim.cmd "delm! | delm A-Z" end

function M.setup()
  -- Register the commands
  vim.api.nvim_create_user_command("DeleteMarks", function() M.delete_marks() end, {
    desc = "Remove marks in the current buffer",
  })
  vim.api.nvim_create_user_command("DeleteAllMarks", function() M.delete_all_marks() end, {
    desc = "Remove all marks",
  })
end

return M
