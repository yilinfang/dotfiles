-- Autoformat
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    -- HACK: Customized keymap
    {
      "<leader>f",
      function() require("conform").format { async = true, lsp_format = "fallback" } end,
      mode = "n",
      desc = "[F]ormat buffer",
    },
    {
      "<leader>F",
      function() require("conform").format { formatters = { "injected" }, timeout_ms = 3000 } end,
      mode = { "n", "v" },
      desc = "[F]ormat Injected Langs",
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
