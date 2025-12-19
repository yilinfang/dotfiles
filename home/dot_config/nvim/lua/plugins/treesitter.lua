-- lua/plugins/treesitter.lua
-- Configuration for `nvim-treesitter`

-- local ensure_installed = {
--   'bash',
--   'c',
--   'diff',
--   'html',
--   'javascript',
--   'jsdoc',
--   'json',
--   'json5',
--   'jsonc',
--   'lua',
--   'luadoc',
--   'luap',
--   'markdown',
--   'markdown_inline',
--   'ninja',
--   'printf',
--   'python',
--   'query',
--   'regex',
--   'rst',
--   'toml',
--   'tsx',
--   'typescript',
--   'vim',
--   'vimdoc',
--   'xml',
-- }

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

-- Build a set to cache available parsers
local available_parsers = nil
local function build_available_parsers()
  local ap = {}
  -- Get both stable (1) and unstable (2) parsers,
  --  unmaintained (3) and unsupported (4) parsers are ignored
  vim.list_extend(ap, ts.get_available(1))
  vim.list_extend(ap, ts.get_available(2))
  local s = {}
  for _, v in ipairs(ap) do
    s[v] = true
  end
  available_parsers = s
end

local function is_available(lang)
  if not available_parsers then build_available_parsers() end
  return available_parsers ~= nil and available_parsers[lang] == true
end

local function safe_install(langs)
  if not cli_functional then return end
  local to_install = vim.tbl_filter(
    function(lang) return isnt_installed(lang) and is_available(lang) end,
    langs
  )
  if #to_install > 0 then ts.install(to_install) end
end

-- -- Install essential parsers (async, no-op if already installed)
-- safe_install(ensure_installed)

local ts_start = function(ev) vim.treesitter.start(ev.buf) end
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('DownloadAndEnableTreesitter', { clear = true }),
  pattern = '*',
  callback = function(ev)
    local ft = ev.match
    -- Skip disabled filetypes
    if vim.tbl_contains(disabled_filetype, ft) then return end
    local lang = vim.treesitter.language.get_lang(ft) or ft
    if not lang or lang == '' then return end
    -- If parser is already installed, start treesitter
    if not isnt_installed(lang) then
      ts_start(ev)
      return
    end
    -- Otherwise, try to install the parser safely
    safe_install({ lang })
    -- After a delay (5 seconds), check if installation succeeded and start treesitter
    -- You can also use `:e(dit)` to reload the buffer when installation is done
    vim.defer_fn(function()
      if not isnt_installed(lang) then ts_start(ev) end
    end, 5000)
  end,
})
