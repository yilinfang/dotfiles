-- lua/utils/events.lua
-- This module defines custom events for lazy loading modules in Neovim.

local M = {}

-- Define LazyFile event
M.LazyFile = {
  "BufReadPost",
  "BufNewFile",
  "BufWritePost",
}

return M
