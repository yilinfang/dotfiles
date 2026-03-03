-- lua/config/treesitter.lua
-- Configuration for `nvim-treesitter`

-- Enabled languages
local langs = {
  'bash',
  'c',
  'cpp',
  'diff',
  'go',
  'html',
  'javascript',
  'json',
  'lua',
  'luadoc',
  'make',
  'markdown',
  'markdown_inline',
  'ninja',
  'python',
  'rst',
  'rust',
  'toml',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
  'yaml',
}

-- A parser is available when a built-in or installed parser file exists in runtimepath.
local is_available = function(lang)
  return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) > 0
end

local isnt_installed = function(lang) return not is_available(lang) end
local to_install = vim.tbl_filter(isnt_installed, langs)
local has_cc = vim.fn.executable('cc') == 1
if has_cc and #to_install > 0 then require('nvim-treesitter').install(to_install) end

-- Enable tree-sitter after opening a file for a target language
local available_langs = vim.tbl_filter(is_available, langs)
local filetypes = {}
local filetype_set = {}
for _, lang in ipairs(available_langs) do
  for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
    if not filetype_set[ft] then
      filetype_set[ft] = true
      table.insert(filetypes, ft)
    end
  end
end
local ts_start = function(ev) vim.treesitter.start(ev.buf) end
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('start-treesitter', { clear = true }),
  desc = 'Start treesitter',
  pattern = filetypes,
  callback = ts_start,
})
