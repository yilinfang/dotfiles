-- lua/plugins/custom/statuscolumn.lua
-- Customized statuscolumn

local M = {}

local function get_mark(bufnr, lnum)
  -- Get all marks for the current buffer
  local marks = vim.fn.getmarklist(bufnr)
  local global_marks = vim.fn.getmarklist()

  -- Check buffer-local marks (a-z)
  for _, mark in ipairs(marks) do
    if mark.pos[2] == lnum and mark.mark:match "^'[a-z]$" then
      return mark.mark:sub(2, 2) -- Return just the letter
    end
  end

  -- Check global marks (A-Z, 0-9)
  for _, mark in ipairs(global_marks) do
    if mark.pos[1] == bufnr and mark.pos[2] == lnum and mark.mark:match "^'[A-Z]$" then
      return mark.mark:sub(2, 2) -- Return just the letter/number
    end
  end

  return nil -- No mark found
end

local function statuscolumn()
  local nu = vim.wo.number
  local rnu = vim.wo.relativenumber
  local bufnr = vim.api.nvim_get_current_buf()
  local lnum_actual = vim.v.lnum

  -- First column: marks
  local mark_col = " "
  if vim.v.virtnum == 0 then -- Only show marks on real lines
    local mark = get_mark(bufnr, lnum_actual)
    if mark then
      -- Check if StatusColumnMark highlight group exists
      local highlight = ""
      if vim.fn.hlID "StatusColumnMark" == 0 then
        highlight = "%#LineNr#" -- Fallback highlight group
      else
        highlight = "%#StatusColumnMark#"
      end
      mark_col = highlight .. mark
    end
  end

  -- Line numbers
  local lnum_display
  if vim.v.virtnum == 0 then
    if rnu and nu and vim.v.relnum == 0 then
      lnum_display = vim.v.lnum
    elseif rnu then
      lnum_display = vim.v.relnum
    else
      lnum_display = vim.v.lnum
    end
  else
    lnum_display = ""
  end

  -- Format: [mark] [space] [right-aligned line number] [signs via %s]
  return mark_col .. " " .. "%=" .. lnum_display .. "%s"
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
