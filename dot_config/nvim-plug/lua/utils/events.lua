-- events.lua
-- This file defines some events for lazy loading plugins.

local M = {}

-- Define LazyFile event
M.LazyFile = {
  "BufReadPost",
  "BufNewFile",
  "BufWritePost",
}

return M
