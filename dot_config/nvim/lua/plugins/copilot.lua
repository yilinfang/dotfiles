-- HACK: copilot.lua
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
      markdown = true,
      yaml = true,
      [""] = false, -- Disable Copilot for unknown filetypes by default
    },
  },
  config = function(_, opts)
    require("copilot").setup(opts)
    -- NOTE: Disable it as if can not disable copilot correctly
    -- Toogle Copilot
    -- vim.keymap.set("n", "<leader>tc", "<cmd>Copilot toggle<CR>", { desc = "[T]oggle [C]opilot" })

    local cmd = require "copilot.command"

    -- Disable Copilot
    vim.keymap.set("n", "<leader>cd", function()
      cmd.detach() -- NOTE: Try to detach first
      cmd.disable()
      vim.notify("Copilot Disabled", vim.log.levels.INFO, { title = "Copilot" })
    end, { desc = "[C]opilot: [D]isable Copilot" })

    -- Enable Copilot
    vim.keymap.set("n", "<leader>ce", function()
      cmd.enable()
      cmd.attach { force = true } -- HACK: Force attach to the current buffer
      vim.notify("Copilot Enabled", vim.log.levels.INFO, { title = "Copilot" })
    end, { desc = "[C]opilot: [E]nable Copilot" })
  end,
}
