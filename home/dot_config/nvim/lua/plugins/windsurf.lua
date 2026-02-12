-- lua/plugins/windsurf.lua

local windsurf_disabled_filetypes = vim.g.windsrf_disabled_filetypes
  or {
    "fzf",
    "help",
    "netrw",
    "neo-tree",
    "minifiles",
    "tutor",
    "man",
    "qf",
    "", -- Unknown filetype
  }

vim.g.codeium_enabled = true
-- Make sure the table exists before indexing it
vim.g.codium_filetypes = vim.g.codium_filetypes or {}
for _, ft in ipairs(windsurf_disabled_filetypes) do
  vim.g.codium_filetypes[ft] = false
end

return {
  "Exafunction/windsurf.vim",
  config = function()
    vim.cmd([[
    
    imap <script><silent><nowait><expr> <M-w> codeium#AcceptNextWord()
    imap <script><silent><nowait><expr> <M-l> codeium#AcceptNextLine()
    
    ]])
  end,
}
