-- lua/config/conform.lua
-- Configuration for `conform.nvim`

local conform = require('conform')

local formatters_by_ft = {}
-- If stylua is installed
if vim.fn.executable('stylua') == 1 then formatters_by_ft.lua = { 'stylua' } end
-- If ruff is installed
if vim.fn.executable('ruff') == 1 then formatters_by_ft.python = { 'ruff_format' } end
-- If shfmt is installed
if vim.fn.executable('shfmt') == 1 then
  formatters_by_ft.sh = { 'shfmt' }
  formatters_by_ft.bash = { 'shfmt' }
  formatters_by_ft.zsh = { 'shfmt' }
end
-- If taplo is installed
if vim.fn.executable('taplo') == 1 then formatters_by_ft.toml = { 'taplo' } end
-- If fish_indent is installed
if vim.fn.executable('fish_indent') == 1 then formatters_by_ft.fish = { 'fish_indent' } end
-- If prettier is installed
if vim.fn.executable('prettier') == 1 then
  formatters_by_ft.markdown = { 'prettier' }
  formatters_by_ft.json = { 'prettier' }
  formatters_by_ft.yaml = { 'prettier' }
  formatters_by_ft.html = { 'prettier' }
  formatters_by_ft.javascript = { 'prettier' }
  formatters_by_ft.css = { 'prettier' }
end
conform.setup({
  formatters_by_ft = formatters_by_ft,
  notify_on_error = false,
  format_on_save = function(bufnr)
    -- HACK: Disable if vim.g.conform_global_disable_format_on_save is set
    if vim.g.conform_global_disable_format_on_save then return nil end

    -- HACK: Disable if vim.b.conform_disable_format_on_save is set
    if vim.b[bufnr].conform_disable_format_on_save then return nil end

    -- Disable `format_on_save lsp_fallback` for languages that don't
    -- have a well standardized coding style. You can add additional
    -- languages here or re-enable it for the disabled ones.
    local disable_filetypes = { c = true, cpp = true }
    if disable_filetypes[vim.bo[bufnr].filetype] then return nil end
    return {
      timeout_ms = 500,
      lsp_format = 'fallback',
    }
  end,
})
vim.keymap.set(
  'n',
  'grf',
  function() conform.format({ async = true, lsp_format = 'fallback' }) end,
  { desc = 'Conform: [F]ormat Buffer' }
)
vim.keymap.set(
  'v',
  'grf',
  function() conform.format({ async = true, lsp_format = 'fallback' }) end,
  { desc = 'Conform: [F]ormat Selection' }
)

-- HACK: Toggle format on save
vim.keymap.set('n', '<leader>tf', function()
  -- local bufnr = vim.api.nvim_get_current_buf()
  -- if vim.b[bufnr].conform_disable_format_on_save then
  --   vim.b[bufnr].conform_disable_format_on_save = nil
  --   vim.notify('Conform: format on save enabled', vim.log.levels.INFO)
  -- else
  --   vim.b[bufnr].conform_disable_format_on_save = true
  --   vim.notify('Conform: format on save disabled', vim.log.levels.INFO)
  -- end
  if vim.g.conform_global_disable_format_on_save then
    vim.g.conform_global_disable_format_on_save = nil
    vim.notify('Conform: format on save enabled', vim.log.levels.INFO)
  else
    vim.g.conform_global_disable_format_on_save = true
    vim.notify('Conform: format on save disabled', vim.log.levels.INFO)
  end
end, { desc = '[T]oggle Conform [F]ormat on Save' })

-- HACK: Save without formatting
vim.keymap.set('n', '<leader>w', function()
  local bufnr = vim.api.nvim_get_current_buf()
  local original_value = vim.b[bufnr].conform_disable_format_on_save
  vim.b[bufnr].conform_disable_format_on_save = true
  vim.cmd.write()
  vim.b[bufnr].conform_disable_format_on_save = original_value
  vim.notify('Write buffer without formatting', vim.log.levels.INFO)
end, { desc = '[W]rite buffer without formatting' })
