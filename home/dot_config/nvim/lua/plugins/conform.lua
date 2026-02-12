-- lua/plugins/conform.lua

local formatters_by_ft = {}
-- If stylua is installed
if vim.fn.executable("stylua") == 1 then
  formatters_by_ft.lua = { "stylua" }
end
-- If ruff is installed
if vim.fn.executable("ruff") == 1 then
  formatters_by_ft.python = { "ruff_format" }
end
-- If shfmt is installed
if vim.fn.executable("shfmt") == 1 then
  formatters_by_ft.sh = { "shfmt" }
  formatters_by_ft.bash = { "shfmt" }
  formatters_by_ft.zsh = { "shfmt" }
end
-- If taplo is installed
if vim.fn.executable("taplo") == 1 then
  formatters_by_ft.toml = { "taplo" }
end
-- If fish_indent is installed
if vim.fn.executable("fish_indent") == 1 then
  formatters_by_ft.fish = { "fish_indent" }
end
-- If prettier is installed
if vim.fn.executable("prettier") == 1 then
  formatters_by_ft.markdown = { "prettier" }
  formatters_by_ft.json = { "prettier" }
  formatters_by_ft.jsonc = { "prettier" }
  formatters_by_ft.yaml = { "prettier" }
  formatters_by_ft.html = { "prettier" }
  formatters_by_ft.javascript = { "prettier" }
  formatters_by_ft.css = { "prettier" }
end

-- HACK: Toggle autoformat on save
vim.api.nvim_create_user_command("ToggleAutoformat", function()
  if vim.g.autoformat then
    vim.g.autoformat = false
    vim.notify("Autoformat disabled", vim.log.levels.INFO)
  else
    vim.g.autoformat = true
    vim.notify("Autoformat enabled", vim.log.levels.INFO)
  end
end, {
  desc = "Toggle autoformat on save",
})

-- HACK: Save without formatting
vim.api.nvim_create_user_command("SaveWithoutFormat", function()
  local origin_value = vim.g.autoformat
  vim.g.autoformat = false
  vim.cmd.write()
  vim.g.autoformat = origin_value
end, {
  desc = "Save without formatting",
})

return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = formatters_by_ft,
  },
}
