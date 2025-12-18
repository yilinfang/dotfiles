-- lua/plugins/treesitter.lua
-- Configuration for `nvim-treesitter`

local ensure_installled = {
  'bash',
  'css',
  'diff',
  'html',
  'markdown_inline',
  'javascript',
  'json',
  'python',
  'query',
  'regex',
  'toml',
  'yaml',
}

local disabled = {
  'cpp',
  'csv',
  'dockerfile',
  'gitignore',
  'rust',
  'tmux',
}

local ts = require('nvim-treesitter')

local function check_cli_health()
  if vim.fn.executable('tree-sitter') == 0 then return false end
  -- Try running it; if glibc is too old, this will return a non-zero shell_error
  local output = vim.fn.system('tree-sitter --version')
  return vim.v.shell_error == 0
end

local cli_functional = check_cli_health()

local function safe_install(langs)
  if cli_functional then pcall(ts.install, langs) end
end

-- Install essential parsers (async, no-op if already installed)
safe_install(ensure_installled)

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('DownloadAndEnableTreesitter', { clear = true }),
  pattern = '*',
  callback = function(ev)
    local ft = ev.match
    if vim.tbl_contains(disabled, ft) then return end
    local lang = vim.treesitter.language.get_lang(ev.match) or ev.match
    local buf = ev.buf
    -- Enable treesitter highlighting
    pcall(vim.treesitter.start, buf, lang)
    -- Install missing parsers (async, no-op if already installed)
    safe_install({ lang })
  end,
})

-- NOTE: Old configuration using `nvim-treesitter.configs` for `master` branch
-- local tsc = require('nvim-treesitter.configs')
-- local ensure_installed = {
--   'bash',
--   'css',
--   'diff',
--   'html',
--   'markdown_inline',
--   'javascript',
--   'json',
--   'python',
--   'query',
--   'regex',
--   'toml',
--   'yaml',
-- }
-- local disabled = {
--   'cpp',
--   'csv',
--   'dockerfile',
--   'gitignore',
--   'rust',
--   'tmux',
-- }
-- local ignore_install = vim.deepcopy(disabled)
-- ignore_install = vim.list_extend(ignore_install, {
--   -- Do not install following parsers as they are built-in in Neovim
--   'c',
--   'lua',
--   'markdown',
--   'query',
--   'vim',
--   'vimdoc',
-- })
--
-- ---@diagnostic disable-next-line: missing-fields
-- tsc.setup({
--   ensure_installed = {},
--   ignore_install = ignore_install,
--   sync_install = false,
--   auto_install = true,
--   highlight = {
--     enable = true,
--     disable = function(lang, buf)
--       if vim.tbl_contains(disabled, lang) then return true end
--       local max_filesize = 100 * 1024 -- 100 KB
--       local ok, stats = pcall((vim.uv or vim.loop).fs_stat, vim.api.nvim_buf_get_name(buf))
--       if ok and stats and stats.size > max_filesize then return true end
--       return false
--     end,
--   },
-- })
