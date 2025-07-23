-- lua/plugins/config/mini/pick.lua
-- Configuration for mini.pick

local pick_ok, pick = pcall(require, "mini.pick")
if pick_ok then
  pick.setup {}

  -- [[ Buitlin pickers ]]
  -- Map <leader><leader> to serach buffers
  vim.keymap.set("n", "<leader><leader>", "<cmd>Pick buffers<cr>", { desc = "[' '] Search Buffers" })
  -- Map <leader>sh to search help tags
  vim.keymap.set("n", "<leader>sh", "<cmd>Pick help<cr>", { desc = "[S]earch [H]elp" })
  -- Map <leader>sr to resume last search
  vim.keymap.set("n", "<leader>sr", "<cmd>Pick resume<cr>", { desc = "[S]earch [R]esume" })
  -- Map <leader>sd to search diagnostics
  vim.keymap.set("n", "<leader>sd", "<cmd>Pick diagnostic<cr>", { desc = "[S]earch [D]iagnostic" })
  -- Map <leader>sk to search keymaps
  vim.keymap.set("n", "<leader>sk", "<cmd>Pick keymaps<cr>", { desc = "[S]earch [K]eymaps" })
  -- Map <leader>st to search treesitter symbols
  vim.keymap.set("n", "<leader>st", "<cmd>Pick treesitter<cr>", { desc = "[S]earch [T]reesitter Nodes" })
  -- Map <leader>s. to search old files
  vim.keymap.set("n", "<leader>s.", "<cmd>Pick oldfiles<cr>", { desc = "[S]earch Old Files (['.'] for repeat)" })
  -- Map <leader>sm to search marks
  vim.keymap.set("n", "<leader>sm", "<cmd>Pick marks<cr>", { desc = "[S]earch [M]arks" })

  -- [[ LSP pickers ]]
  -- NOTE: Only available when LSP is attached
  --  It will override some of the default LSP keymaps
  vim.api.nvim_create_autocmd("LspAttach", {
    desc = "Configure LSP pickers on attach",
    group = vim.api.nvim_create_augroup("mini-pick-lsp-attach", { clear = true }),
    callback = function(event)
      local map = function(keys, func, desc, mode)
        mode = mode or "n"
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
      end
      local unmap = function(keys, mode)
        mode = mode or "n"
        vim.keymap.del(mode, keys, { buffer = event.buf })
      end
      unmap "grr"
      unmap "grd"
      unmap "gri"
      unmap "grD"
      unmap "gO"
      unmap "gW"
      unmap "grt"
      local extra_ok, extra = pcall(require, "mini.extra")
      if extra_ok then
        -- Fuzzy find all references under cursor
        map("grr", function() extra.pickers.lsp { scope = "references" } end, "[G]oto [R]eferences")
        -- Jump to the implementation of the word under cursor
        map("gri", function() extra.pickers.lsp { scope = "implementation" } end, "[G]oto [I]mplementation")
        -- Jump to the definition of the word under cursor
        map("grd", function() extra.pickers.lsp { scope = "definition" } end, "[G]oto [D]efinition")
        -- Jump to the declaration of the word under cursor
        map("grD", function() extra.pickers.lsp { scope = "declaration" } end, "[G]oto [D]eclaration")
        -- Fuzzy find all the symbols in current document
        map("gO", function() extra.pickers.lsp { scope = "document_symbol" } end, "Open Document Symbols")
        -- Fuzzy find all the symbols in current workspace
        map("gW", function() extra.pickers.lsp { scope = "workspace_symbol" } end, "Open Workspace Symbols")
        -- Jump to the type definition of the word under cursor
        map("grt", function() extra.pickers.lsp { scope = "type_definition" } end, "[G]oto [T]ype Definition")
      else
        vim.notify("mini.extra not found, LSP pickers will not work.", vim.log.levels.WARN)
      end
    end,
  })

  -- [[ Custom pickers]]
  -- Map <leader>sj to search jumplist
  vim.keymap.set("n", "<leader>sj", "<cmd>Pick list scope='jump'<cr>", { desc = "[S]earch [J]umplist" })

  -- Map <leader>sf to search files
  pick.registry.customized_files = function()
    local cache_rg_config = vim.uv.os_getenv "RIPGREP_CONFIG_PATH"
    -- Temporarily set the RIGPREP_CONFIG_PATH to ~/.config/nvim/.rg/files
    vim.uv.os_setenv("RIPGREP_CONFIG_PATH", vim.fn.stdpath "config" .. "/.rg/files")
    pick.builtin.files { tool = "rg" }
    -- Restore the original RIPGREP_CONFIG_PATH
    vim.uv.os_setenv("RIPGREP_CONFIG_PATH", cache_rg_config)
  end
  vim.keymap.set("n", "<leader>sf", "<cmd>Pick customized_files<cr>", { desc = "[S]earch [F]iles" })

  -- Map <leader>sF to search files (including files ignored by git)
  pick.registry.customized_files_all = function()
    local cache_rg_config = vim.uv.os_getenv "RIPGREP_CONFIG_PATH"
    -- Temporarily set the RIGPREP_CONFIG_PATH to ~/.config/nvim/.rg/files_all
    vim.uv.os_setenv("RIPGREP_CONFIG_PATH", vim.fn.stdpath "config" .. "/.rg/files_all")
    pick.builtin.files { tool = "rg" }
    -- Restore the original RIPGREP_CONFIG_PATH
    vim.uv.os_setenv("RIPGREP_CONFIG_PATH", cache_rg_config)
  end
  vim.keymap.set(
    "n",
    "<leader>sF",
    "<cmd>Pick customized_files_all<cr>",
    { desc = "[S]earch [F]iles (including ignored files)" }
  )

  -- Map <leader>sg to search grep
  pick.registry.customized_grep_live = function()
    local cache_rg_config = vim.uv.os_getenv "RIPGREP_CONFIG_PATH"
    -- Temporarily set the RIGPREP_CONFIG_PATH to ~/.config/nvim/.rg/grep
    vim.uv.os_setenv("RIPGREP_CONFIG_PATH", vim.fn.stdpath "config" .. "/.rg/grep")
    pick.builtin.grep_live { tool = "rg" }
    -- Restore the original RIPGREP_CONFIG_PATH
    vim.uv.os_setenv("RIPGREP_CONFIG_PATH", cache_rg_config)
  end
  vim.keymap.set("n", "<leader>sg", "<cmd>Pick customized_grep_live<cr>", { desc = "[S]earch by [G]rep" })

  -- Map <leader>sG to search grep (including files ignored by git)
  pick.registry.customized_grep_live_all = function()
    local cache_rg_config = vim.uv.os_getenv "RIPGREP_CONFIG_PATH"
    -- Temporarily set the RIGPREP_CONFIG_PATH to ~/.config/nvim/.rg/grep_all
    vim.uv.os_setenv("RIPGREP_CONFIG_PATH", vim.fn.stdpath "config" .. "/.rg/grep_all")
    pick.builtin.grep_live { tool = "rg" }
    -- Restore the original RIPGREP_CONFIG_PATH
    vim.uv.os_setenv("RIPGREP_CONFIG_PATH", cache_rg_config)
  end
  vim.keymap.set(
    "n",
    "<leader>sG",
    "<cmd>Pick customized_grep_live_all<cr>",
    { desc = "[S]earch by [G]rep (including ignored files)" }
  )
else
  vim.notify("mini.pick not found", vim.log.levels.WARN)
end
