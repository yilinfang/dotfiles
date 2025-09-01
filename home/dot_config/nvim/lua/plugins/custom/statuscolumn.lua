-- lua/plugins/custom/statuscolumn.lua
-- A customized, pretty, vscode-like status column for Neovim

local M = {}

local function statuscolumn()
  local nu = vim.wo.number
  local rnu = vim.wo.relativenumber
  local lnum
  if vim.v.virtnum == 0 then
    if rnu and nu and vim.v.relnum == 0 then
      lnum = vim.v.lnum
    elseif rnu then
      lnum = vim.v.relnum
    else
      lnum = vim.v.lnum
    end
  else
    lnum = ""
  end
  return "  " .. "%=" .. lnum .. "%s"
end

function M.setup()
  -- Only show sign with highest priority
  vim.o.signcolumn = "yes:1"
  -- HACK: Minmal number of columns for line numbers
  --  Set to 1 to only use essential columns for line numbers.
  --  For example, if line number less than 100, it will only use 2 columns.
  --  If line number is 100 or more, it will use 3 columns or more.
  vim.o.numberwidth = 1
  -- Register the function globally
  _G.custom_statuscolumn = statuscolumn
  -- Apply the custom status column function
  vim.o.statuscolumn = "%!v:lua.custom_statuscolumn()"
end

return M
