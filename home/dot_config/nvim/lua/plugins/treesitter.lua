-- lua/plugins/treesitter.lua
-- Configuration for `nvim-treesitter`
-- TODO: Switch to `main` branch once it is stable

local tsc = require('nvim-treesitter.configs')
-- local ensure_installed = {
--   "bash",
--   "css",
--   "diff",
--   "html",
--   "markdown_inline",
--   "javascript",
--   "json",
--   "python",
--   "query",
--   "regex",
--   "toml",
--   "yaml",
-- }
local disabled = {
  'cpp',
  'csv',
  'dockerfile',
  'gitignore',
  'rust',
  'tmux',
}
local ignore_install = vim.deepcopy(disabled)
ignore_install = vim.list_extend(ignore_install, {
  -- Do not install following parsers as they are built-in in Neovim
  'c',
  'lua',
  'markdown',
  'query',
  'vim',
  'vimdoc',
  'vimscript',
})

---@diagnostic disable-next-line: missing-fields
tsc.setup({
  ensure_installed = {},
  ignore_install = ignore_install,
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    disable = function(lang, buf)
      if vim.tbl_contains(disabled, lang) then return true end
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall((vim.uv or vim.loop).fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then return true end
      return false
    end,
  },
})
