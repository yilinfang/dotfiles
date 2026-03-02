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

-- Install missing parsers
local isnt_installed = function(lang)
  return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) == 0
end
local to_install = vim.tbl_filter(isnt_installed, langs)
if #to_install > 0 then require('nvim-treesitter').install(to_install) end

-- Enable tree-sitter after opening a file for a target language
local filetypes = {}
for _, lang in ipairs(langs) do
  for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
    table.insert(filetypes, ft)
  end
end
local ts_start = function(ev) vim.treesitter.start(ev.buf) end
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('start-treesitter', { clear = true }),
  desc = 'Start treesitter',
  pattern = filetypes,
  callback = ts_start,
})
