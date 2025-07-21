-- lua/plugins/telescope.lua
-- Fuzzy Finder (files, lsp, etc)

return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy", -- HACK: Load on VeryLazy instead of VimEnter
  cmd = { "Telescope" }, -- HACK: Load on command Telescope
  dependencies = {
    "nvim-lua/plenary.nvim",
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      "nvim-telescope/telescope-fzf-native.nvim",

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = "make",

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function() return vim.fn.executable "make" == 1 end,
    },
    -- { "nvim-telescope/telescope-ui-select.nvim" },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { "nvim-tree/nvim-web-devicons", enabled = true },
  },
  config = function()
    -- HACK: Exclude patterns for Telescope
    local exclude_patterns = vim.g.telescope_exclude_patterns or {
      "!**/.git/*",
      "!**/.DS_Store",
    }

    -- HACK: Customized vimgrep_arguments
    local vimgrep_arguments = {
      "rg",
      "--no-config", -- Do not follow the user's ripgrep configuration
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--follow", -- Follow symlinks
      "--hidden", -- Include hidden files
    }
    for _, pattern in ipairs(exclude_patterns) do
      vim.list_extend(vimgrep_arguments, { "--glob", pattern })
    end

    -- HACK: Customized find_command
    local get_find_command = function()
      local command = {
        "rg",
        "--no-config", -- Do not follow the user's ripgrep configuration
        "--color=never",
        "--files", -- Search for files
        "--follow", -- Follow symlinks
        "--hidden", -- Include hidden files
      }
      for _, pattern in ipairs(exclude_patterns) do
        vim.list_extend(command, { "--glob", pattern })
      end
      return command
    end

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require("telescope").setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      defaults = {
        vimgrep_arguments = vimgrep_arguments,
        mappings = {
          n = {
            ["q"] = "close", -- Use 'q' to close the prompt in normal mode
          },
        },
      },
      pickers = {
        find_files = {
          find_command = get_find_command,
          -- HACK: Disable the following options as they are set in the `find_command`
          hidden = false,
          follow = false,
          no_ignore = false,
        },
      },
    }
    -- Enable Telescope extensions if they are installed
    pcall(require("telescope").load_extension, "fzf")

    -- See `:help telescope.builtin`
    local builtin = require "telescope.builtin"
    vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
    vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
    vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
    vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
    vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
    vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
    vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
    vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
    vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set(
      "n",
      "<leader>sn",
      function() builtin.find_files { cwd = vim.fn.stdpath "config" } end,
      { desc = "[S]earch [N]eovim files" }
    )

    -- HACK: Customized keymaps for telescope

    -- Fuzzliy search in current buffer
    vim.keymap.set(
      "n",
      "<leader>/",
      builtin.current_buffer_fuzzy_find,
      { desc = "[/] Fuzzily search in current buffer" }
    )

    -- Find all files (including ignored files)
    vim.keymap.set("n", "<leader>sF", function()
      builtin.find_files {
        find_command = function()
          local command = get_find_command()
          return vim.list_extend(command, { "--no-ignore-vcs" })
        end,
        prompt_title = "Find Files (including ignored files)",
      }
    end, { desc = "[S]earch All [F]iles (including ignored files)" })

    -- Live grep in all files (including ignored files)
    vim.keymap.set("n", "<leader>sG", function()
      builtin.live_grep {
        additional_args = function()
          return {
            "--no-ignore-vcs", -- Include ignored files
          }
        end,
        prompt_title = "Live Grep (including ignored files)",
      }
    end, { desc = "[S]earch by [G]rep (including ignored files)" })

    -- Search jumplist
    vim.keymap.set("n", "<leader>sj", builtin.jumplist, { desc = "[S]earch [J]umplist" })

    -- Search marks
    vim.keymap.set("n", "<leader>sm", builtin.marks, { desc = "[S]earch [M]arks" })
  end,
}
