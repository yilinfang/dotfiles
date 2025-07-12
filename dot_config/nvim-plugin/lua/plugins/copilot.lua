-- lua/plugins/copilot.lua
-- HACK: Copilot.lua

return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = { unpack(require("utils.events").LazyFile) }, -- HACK: Set the event of copilot.lua to LazyFile
  build = ":Copilot auth",
  opts = {
    suggestion = {
      enabled = true,
      auto_trigger = true,
      hide_during_completion = false,
      keymap = {
        accept = "<M-y>",
        accept_word = "<M-w>",
        accept_line = "<M-l>",
        next = "<M-n>",
        prev = "<M-p>",
        dismiss = "<M-d>",
      },
    },
    panel = { enabled = false },
    filetypes = {
      yaml = true,
      markdown = true,
      text = false,
      [""] = false, -- HACK: Disable copilot for all unknown filetypes
    },
  },
  config = function(_, opts)
    require("copilot").setup(opts)

    -- Toggle Copilot
    vim.keymap.set(
      "n",
      "<leader>tc",
      -- HACK: Better toggle
      -- Enable copilot if it is disabled
      -- Attach copilot forcely if it is enabled but not attached normally
      -- Disable copilot if it is enabled and attached
      function()
        local cli = require "copilot.client"
        local cmd = require "copilot.command"
        if cli.is_disabled() then -- If Copilot is disabled, enable it
          cmd.enable()
          vim.notify("Copilot enabled", vim.log.levels.INFO, { title = "Copilot" })
          vim.defer_fn(
            function() -- HACK: If copilot is not attached automatically, try to attach it after a short delay
              if not cli.buf_is_attached(0) then
                cmd.attach { force = true }
                vim.notify("Copilot attached forcely", vim.log.levels.INFO, { title = "Copilot" })
              end
            end,
            1000
          )
        elseif not cli.buf_is_attached(0) then -- If Copilot is enabled but not attached normally, attach it forcely
          cmd.attach { force = true }
          vim.notify("Copilot attached forcely", vim.log.levels.INFO, { title = "Copilot" })
        else -- If Copilot is enabled and attached, disable it
          cmd.disable()
          vim.notify("Copilot disabled", vim.log.levels.INFO, { title = "Copilot" })
        end
      end,
      { desc = "[T]oggle [C]opilot" }
    )
  end,
}
