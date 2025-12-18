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
  local _ = vim.fn.system('tree-sitter --version')
  return vim.v.shell_error == 0
end

local isnt_installed = function(lang)
  return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) == 0
end

-- Check CLI health once
local cli_funcional = check_cli_health()
if not cli_funcional then
  vim.notify_once(
    'tree-sitter CLI not found or not working properly, skipping treesitter parser installation.',
    vim.log.levels.WARN
  )
end

local function safe_install(langs)
  if not cli_funcional then return end
  local to_install = vim.tbl_filter(isnt_installed, langs)
  if #to_install > 0 then pcall(ts.install, to_install) end
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
