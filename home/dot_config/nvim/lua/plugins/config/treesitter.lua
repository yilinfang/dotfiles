-- lua/plugins/custom/treesitter.lua
-- Configuration for nvim-treesitter
-- NOTE: Remember to run :TSUpdate when updating Neovim or nvim-treesitter

-- Check if nvim-treesitter.config is available
local ok, ts = pcall(require, "nvim-treesitter.configs")
if ok then
  ts.setup {
    ensure_installed = {},
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
      disable = function(lang, buf)
        local disabled_langs = { "c", "rust", "tmux", "dockerfile" }
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
