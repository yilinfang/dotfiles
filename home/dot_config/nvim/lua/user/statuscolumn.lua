-- lua/user/statuscolumn.lua
-- Customized statuscolumn

local M = {}
local mark_cache = {}

local function get_mark(bufnr, lnum)
  -- Build cache for entire buffer if not cached
  if not mark_cache[bufnr] then
    mark_cache[bufnr] = {}

    -- Get all marks for current buffer
    local marks = vim.fn.getmarklist(bufnr)
    local global_marks = vim.fn.getmarklist()

    -- Check buffer-local marks (a-z)
    for _, mark in ipairs(marks) do
      if mark.mark:match("^'[a-z]$") then
        local mark_lnum = mark.pos[2]
        mark_cache[bufnr][mark_lnum] = mark.mark:sub(2, 2)
      end
    end

    -- Check global marks (A-Z) - these override local marks if on same line
    for _, mark in ipairs(global_marks) do
      if mark.pos[1] == bufnr and mark.mark:match("^'[A-Z]$") then
        local mark_lnum = mark.pos[2]
        mark_cache[bufnr][mark_lnum] = mark.mark:sub(2, 2)
      end
    end
  end

  return mark_cache[bufnr][lnum]
end

local function statuscolumn()
  local winid = vim.g.statusline_winid
  if not winid or winid == 0 then winid = vim.api.nvim_get_current_win() end
  local nu = vim.wo[winid].number
  local rnu = vim.wo[winid].relativenumber
  local bufnr = vim.api.nvim_win_get_buf(winid)
  local lnum_actual = vim.v.lnum

  -- First column: marks
  local mark_col = ' '
  if vim.v.virtnum == 0 then -- Only show marks on real lines
    local mark = get_mark(bufnr, lnum_actual)
    if mark then
      -- Check if StatusColumnMark highlight group exists
      local highlight = ''
      if vim.fn.hlID('StatusColumnMark') == 0 then
        highlight = '%#LineNr#' -- Fallback highlight group
      else
        highlight = '%#StatusColumnMark#'
      end
      mark_col = highlight .. mark .. '%*'
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
    lnum_display = ''
  end

  -- Format: [mark] [space] [right-aligned line number] [signs via %s]
  return mark_col .. ' ' .. '%=' .. lnum_display .. '%s'
end

function M.setup()
  -- Clear cache every 200ms
  local timer = assert((vim.uv or vim.loop).new_timer())
  timer:start(0, 500, function() mark_cache = {} end)
  vim.api.nvim_create_autocmd('VimLeavePre', {
    desc = 'Clear StatusColumn Timer on Exit',
    group = vim.api.nvim_create_augroup('ClearStatusColumnTimer', { clear = true }),
    callback = function()
      if timer and not timer:is_closing() then
        timer:stop()
        timer:close()
      end
    end,
  })
  -- Only show sign with highest priority
  vim.o.signcolumn = 'yes:1'
  -- HACK: Minmal number of columns for line numbers
  --  Set to 1 to only use essential columns for line numbers.
  --  For example, if line number less than 100, it will only use 2 columns.
  --  If line number is 100 or more, it will use 3 columns or more.
  vim.o.numberwidth = 1
  -- Register the function globally
  _G.custom_statuscolumn = statuscolumn
  -- Apply the custom status column function
  vim.o.statuscolumn = '%!v:lua.custom_statuscolumn()'
end

return M
