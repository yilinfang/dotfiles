-- lua/plugins/treesitter.lua
-- Configuration for `nvim-treesitter`

local ensure_installed = {
  'bash',
  'c',
  'diff',
  'html',
  'javascript',
  'jsdoc',
  'json',
  'json5',
  'jsonc',
  'lua',
  'luadoc',
  'luap',
  'markdown',
  'markdown_inline',
  'ninja',
  'printf',
  'python',
  'query',
  'regex',
  'rst',
  'toml',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
  'xml',
}

local disabled_filetype = {
  'csv',
  'dockerfile',
  'gitignore',
  'tmux',
}

local ts = require('nvim-treesitter')

local function check_cli_health()
  if vim.fn.executable('tree-sitter') == 0 then return false end
  local _ = vim.fn.system('tree-sitter --version')
  return vim.v.shell_error == 0
end

-- Check CLI health once
local cli_functional = check_cli_health()
if not cli_functional then
  vim.notify_once(
    'tree-sitter CLI not found or not working properly, skipping treesitter parser installation.',
    vim.log.levels.WARN
  )
end

local isnt_installed = function(lang)
  return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) == 0
end

-- Get list of all available parsers, only stable and unstable are considered
-- Unmaintained (3) or unsupported (4) parsers are ignored
local available_parsers = {}
available_parsers = vim.list_extend(available_parsers, ts.get_available(1))
available_parsers = vim.list_extend(available_parsers, ts.get_available(2))

local is_available = function(lang) return vim.tbl_contains(available_parsers, lang) == true end

-- NOTE: No checking for parsers and cli here, must be ensured before calling this
local function install_parser_and_wait(langs, time) ts.install(langs):wait(time or 300000) end

local function safe_install(langs)
  if not cli_functional then return end
  local to_install = vim.tbl_filter(
    function(lang) return isnt_installed(lang) and is_available(lang) end,
    langs
  )
  if #to_install > 0 then install_parser_and_wait(to_install) end
end

-- Install essential parsers (async, no-op if already installed)
safe_install(ensure_installed)

local ts_start = function(ev) vim.treesitter.start(ev.buf) end
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('DownloadAndEnableTreesitter', { clear = true }),
  pattern = '*',
  callback = function(ev)
    local ft = ev.match
    if vim.tbl_contains(disabled_filetype, ft) then return end
    local lang = vim.treesitter.language.get_lang(ft) or ft
    if not isnt_installed(lang) then
      ts_start(ev)
    elseif cli_functional and is_available(lang) then
      -- Call installation function instead of safe_install to avoid redundant checks
      install_parser_and_wait({ lang })
      ts_start(ev)
    end
  end,
})
