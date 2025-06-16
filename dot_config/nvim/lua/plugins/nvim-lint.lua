-- HACK: nvim-lint for lintting
return {
  "mfussenegger/nvim-lint",
  event = { unpack(require("utils.events").LazyFile) }, -- HACK: Set the event of nvim-lint to LazyFile
  config = function(_, opts) -- HACK: Use opts to pass linters_by_ft
    local lint = require "lint"
    lint.linters_by_ft = opts.linters_by_ft or {}

    -- Create autocommand which carries out the actual linting
    -- on the specified events.
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        -- Only run the linter in buffers that you can modify in order to
        -- avoid superfluous noise, notably within the handy LSP pop-ups that
        -- describe the hovered symbol using Markdown.
        if vim.bo.modifiable then lint.try_lint() end
      end,
    })
  end,
}
