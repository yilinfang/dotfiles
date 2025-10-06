-- lua/plugins/config/neo-tree.lua
-- Configuration for neo-tree.nvim

local neo_tree = require "neo-tree"
local opts = {
  sources = { "filesystem", "buffers", "git_status" },
  open_files_do_not_replace_types = { "terminal", "qf" },
  filesystem = {
    bind_to_cwd = false,
    follow_current_file = { enabled = true },
    use_libuv_file_watcher = true,
    hijack_netrw_behavior = "open_current",
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_ignored = false,
      hide_hidden = false,
    },
  },
  window = {
    width = 40,
    mappings = {
      ["l"] = "open",
      ["h"] = "close_node",
      ["<space>"] = "none",
      ["Y"] = {
        function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          vim.fn.setreg("+", path, "c")
        end,
        desc = "Copy Path to Clipboard",
      },
      ["O"] = "none",
      ["P"] = { "toggle_preview", config = { use_float = false } },
    },
  },
}
neo_tree.setup(opts)

-- Keymaps to toggle neo-tree
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "['e'] Toggle File Explorer" })
