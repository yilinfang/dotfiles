-- lua/plugins/conform.lua
-- Autoformat

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  dependencies = {
    "mason-org/mason.nvim", -- HACK: Make sure mason is loaded before conform
  },
  keys = {
    -- HACK: Customized keymap for conform.nvim
    {
      "grf",
      function() require("conform").format { async = true, lsp_format = "fallback" } end,
      mode = "", -- NOTE: "" is required by conform.nvim to make it able to automatically format the buffer or selection
      desc = "Conform: [F]ormat Buffer/Selection",
    },
    {
      "grF",
      function() require("conform").format { formatters = { "injected" }, timeout_ms = 3000 } end,
      mode = "n",
      desc = "Conform: [F]ormat Injected Langs",
    },
  },
  opts = {
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
  },
}
