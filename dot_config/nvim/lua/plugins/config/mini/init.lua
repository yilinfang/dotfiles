-- lua/plugins/config/mini/init.lua
-- Configuration for mini.nvim

-- [[ mini.icons ]]
--  NOTE: Load mini.icons first to ensure icons are available for other modules
local icons_ok, icons = pcall(require, "mini.icons")
if icons_ok then
  icons.setup {}
else
  vim.notify("mini.icons not found", vim.log.levels.WARN)
end

-- [[ mini.extra ]]
local extra_ok, extra = pcall(require, "mini.extra")
if extra_ok then
  extra.setup {}
else
  vim.notify("mini.extra not found", vim.log.levels.WARN)
end

-- [[ mini.keymap ]]
local keymap_ok, keymap = pcall(require, "mini.keymap")
if keymap_ok then
  keymap.setup {}
else
  vim.notify("mini.keymap not found", vim.log.levels.WARN)
end

-- [[ mini.ai ]]
local ai_ok, ai = pcall(require, "mini.ai")
if ai_ok then
  ai.setup { n_lines = 500 }
else
  vim.notify("mini.ai not found", vim.log.levels.WARN)
end

-- [[ mini.comment ]]
local comment_ok, comment = pcall(require, "mini.comment")
if comment_ok then
  comment.setup {}
else
  vim.notify("mini.comment not found", vim.log.levels.WARN)
end

-- [[ mini.move ]]
local move_ok, move = pcall(require, "mini.move")
if move_ok then
  move.setup {}
else
  vim.notify("mini.move not found", vim.log.levels.WARN)
end

-- [[ mini.pairs ]]
local pairs_ok, pairs = pcall(require, "mini.pairs")
if pairs_ok then
  pairs.setup {}
else
  vim.notify("mini.pairs not found", vim.log.levels.WARN)
end

-- [[ mini.surround ]]
local surround_ok, surround = pcall(require, "mini.surround")
if surround_ok then
  surround.setup {}
else
  vim.notify("mini.surround not found", vim.log.levels.WARN)
end

-- [[ mini.git ]]
local git_ok, git = pcall(require, "mini.git")
if git_ok then
  git.setup {}
else
  vim.notify("mini.git not found", vim.log.levels.WARN)
end

-- [[ mini.diff ]]
require "plugins.config.mini.diff"

-- [[ mini.statusline ]]
--  NOTE: mini.icons, mini.git and mini.diff must be loaded before mini.statusline
local statusline_ok, statusline = pcall(require, "mini.statusline")
if statusline_ok then
  statusline.setup {}
else
  vim.notify("mini.statusline not found", vim.log.levels.WARN)
end

-- [[ mini.tabline ]]
local tabline_ok, tabline = pcall(require, "mini.tabline")
if tabline_ok then
  tabline.setup {
    show_icons = true, -- Show icons in the tabline
    show_index = true, -- Show index numbers for tabs
    show_modified = true, -- Show modified status for tabs
  }
else
  vim.notify("mini.tabline not found", vim.log.levels.WARN)
end

-- [[ mini.trailspace ]]
local trailspace_ok, trailspace = pcall(require, "mini.trailspace")
if trailspace_ok then
  trailspace.setup()
else
  vim.notify("mini.trailspace not found", vim.log.levels.WARN)
end

-- [[ mini.hipatterns ]]
require "plugins.config.mini.hipatterns"

-- [[ mini.files ]]
require "plugins.config.mini.files"

-- [[ mini.snippets ]]
require "plugins.config.mini.snippets"

-- [[ mini.completion ]]
require "plugins.config.mini.completion"

-- [[ mini.pick ]]
require "plugins.config.mini.pick"
