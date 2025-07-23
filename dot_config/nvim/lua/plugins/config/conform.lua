-- lua/plugins/config/conform.lua
-- Configuration for conform.nvim

local ok, conform = pcall(require, "conform")
if ok then
  local formatters_by_ft = {}
  -- If stylua is installed
  if vim.fn.executable "stylua" == 1 then formatters_by_ft.lua = { "stylua" } end
  -- If ruff is installed
  if vim.fn.executable "ruff" == 1 then formatters_by_ft.python = { "ruff_format" } end
  -- If shfmt is installed
  if vim.fn.executable "shfmt" == 1 then
    formatters_by_ft.sh = { "shfmt" }
    formatters_by_ft.bash = { "shfmt" }
    formatters_by_ft.zsh = { "shfmt" }
  end
  -- If fish_indent is installed
  if vim.fn.executable "fish_indent" == 1 then formatters_by_ft.fish = { "fish_indent" } end
  -- If prettier is installed
  if vim.fn.executable "prettier" == 1 then
    formatters_by_ft.markdown = { "prettier" }
    formatters_by_ft.json = { "prettier" }
    formatters_by_ft.yaml = { "prettier" }
    formatters_by_ft.html = { "prettier" }
    formatters_by_ft.javascript = { "prettier" }
    formatters_by_ft.css = { "prettier" }
  end
  conform.setup {
    formatters_by_ft = formatters_by_ft,
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 500,
          lsp_format = "fallback",
        }
      end
    end,
  }
  vim.keymap.set(
    "n",
    "grf",
    function() conform.format { async = true, lsp_format = "fallback" } end,
    { desc = "Conform: [F]ormat Buffer" }
  )
else
  vim.notify("conform.nvim not found", vim.log.levels.WARN)
end
