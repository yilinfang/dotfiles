-- lua/plugins.lua
-- Load and configure plugins with Neovim built-in package support

-- Check if the directory exists
local function is_dir_exists(path) return (vim.uv or vim.loop).fs_stat(path) ~= nil end

local chezmoi_source = vim.fn.system("chezmoi source-path"):gsub("\n", "")
local pack_dir = chezmoi_source .. "/nvim-packages"

if not is_dir_exists(pack_dir) then
  vim.notify("Pack directory does not exist: " .. pack_dir, vim.log.levels.WARN)
  return
end

-- Add the pack directory to packpath so Neovim can find the plugins
vim.opt.packpath:prepend(pack_dir)

-- [[ nvim-treesitter ]]
local treesitter_ok, treesitter = pcall(require, "nvim-treesitter.configs") -- Only configure treesitter if it exists (it will be auto-loaded from start/)
if treesitter_ok then
  treesitter.setup {
    ensure_installed = {},
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
      disable = function(lang, buf)
        local disabled_langs = { "c", "rust" }
        if vim.tbl_contains(disabled_langs, lang) then return true end
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall((vim.uv or vim.loop).fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then return true end
        return false
      end,
    },
  }
else
  vim.notify("nvim-treesitter not found", vim.log.levels.WARN)
end

-- [[ vim-sleuth ]]
-- NOTE: vim-sleuth is automatically loaded from start/ and requires no configuration
--  So we leave it empty here
