-- list_helper.lua
-- Helper functions for managing lists in Lua

local M = {}

--- Ensure unique items in a list, preserving order
--- @param list table List of items that may contain duplicates
--- @return table Deduplicated list with original order preserved
function M.ensure_unique(list)
  if not list or type(list) ~= "table" then return {} end

  local seen = {}
  local result = {}

  for _, item in ipairs(list) do
    if not seen[item] then
      seen[item] = true
      table.insert(result, item)
    end
  end

  return result
end

--- Add items to a list only if they don't already exist
--- @param existing table Existing list
--- @param new_items table Items to add
--- @return table Combined list with no duplicates
function M.extend_unique(existing, new_items)
  existing = existing or {}
  new_items = new_items or {}

  local combined = vim.list_extend({}, existing) -- Create a copy

  for _, item in ipairs(new_items) do
    if not vim.tbl_contains(combined, item) then table.insert(combined, item) end
  end

  return combined
end

return M
