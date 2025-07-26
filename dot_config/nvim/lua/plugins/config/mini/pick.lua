-- lua/plugins/config/mini/pick.lua
-- Configuration for mini.pick

local pick_ok, pick = pcall(require, "mini.pick")
if pick_ok then
  pick.setup {}
  vim.ui.select = pick.ui_select -- Use mini.pick as the default UI for vim.ui.select
  -- [[ Buitlin pickers ]]
  vim.keymap.set("n", "<leader><leader>", "<cmd>Pick buffers<cr>", { desc = "[' '] Search Buffers" })
  vim.keymap.set("n", "<leader>sh", "<cmd>Pick help<cr>", { desc = "[S]earch [H]elp" })
  vim.keymap.set("n", "<leader>sr", "<cmd>Pick resume<cr>", { desc = "[S]earch [R]esume" })
  vim.keymap.set("n", "<leader>sd", "<cmd>Pick diagnostic<cr>", { desc = "[S]earch [D]iagnostic" })
  vim.keymap.set("n", "<leader>sk", "<cmd>Pick keymaps<cr>", { desc = "[S]earch [K]eymaps" })
  vim.keymap.set("n", "<leader>st", "<cmd>Pick treesitter<cr>", { desc = "[S]earch [T]reesitter Nodes" })
  vim.keymap.set("n", "<leader>s.", "<cmd>Pick oldfiles<cr>", { desc = "[S]earch Old Files (['.'] for repeat)" })
  vim.keymap.set("n", "<leader>sm", "<cmd>Pick marks<cr>", { desc = "[S]earch [M]arks" })
  vim.keymap.set("n", "<leader>sp", "<cmd>Pick hipatterns<cr>", { desc = "[S]earch Hi[p]atterns" })
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
      local extra_ok, extra = pcall(require, "mini.extra")
      if extra_ok then
        -- Fuzzy find all references under cursor
        unmap "grr"
        map("grr", function() extra.pickers.lsp { scope = "references" } end, "[G]oto [R]eferences")
        -- Jump to the implementation of the word under cursor
        unmap "gri"
        map("gri", function() extra.pickers.lsp { scope = "implementation" } end, "[G]oto [I]mplementation")
        -- Jump to the definition of the word under cursor
        unmap "grd"
        map("grd", function() extra.pickers.lsp { scope = "definition" } end, "[G]oto [D]efinition")
        -- Jump to the declaration of the word under cursor
        unmap "grD"
        map("grD", function() extra.pickers.lsp { scope = "declaration" } end, "[G]oto [D]eclaration")
        -- Fuzzy find all the symbols in current document
        unmap "gO"
        map("gO", function() extra.pickers.lsp { scope = "document_symbol" } end, "Open Document Symbols")
        -- Fuzzy find all the symbols in current workspace
        unmap "gW"
        map("gW", function() extra.pickers.lsp { scope = "workspace_symbol" } end, "Open Workspace Symbols")
        -- Jump to the type definition of the word under cursor
        unmap "grt"
        map("grt", function() extra.pickers.lsp { scope = "type_definition" } end, "[G]oto [T]ype Definition")
      else
        vim.notify("mini.extra not found, LSP pickers will not work.", vim.log.levels.WARN)
      end
    end,
  })

  -- [[ Custom pickers]]
  -- Map <leader>sj to search jumplist
  vim.keymap.set("n", "<leader>sj", "<cmd>Pick list scope='jump'<cr>", { desc = "[S]earch [J]umplist" })

  -- Customized pickers for file and grep
  -- HACK: By changing the RIPGREP_CONFIG_PATH to use a custom configuration
  -- From: https://github.com/echasnovski/mini.nvim/issues/1859#issuecomment-2979332899

  -- Map <leader>sf to search files
  pick.registry.customized_files = function()
    local cache_rg_config = vim.uv.os_getenv "RIPGREP_CONFIG_PATH" or ""
    -- Temporarily set the RIGPREP_CONFIG_PATH to ~/.config/nvim/.rg/files
    vim.uv.os_setenv("RIPGREP_CONFIG_PATH", vim.fn.stdpath "config" .. "/.rg/files")
    pick.builtin.files { tool = "rg" }
    -- Restore the original RIPGREP_CONFIG_PATH
    if cache_rg_config == "" then
      -- If RIPGREP_CONFIG_PATH was not set, remove it to avoid side effects
      vim.uv.os_unsetenv "RIPGREP_CONFIG_PATH"
    else
      vim.uv.os_setenv("RIPGREP_CONFIG_PATH", cache_rg_config)
    end
  end
  vim.keymap.set("n", "<leader>sf", "<cmd>Pick customized_files<cr>", { desc = "[S]earch [F]iles" })

  -- Map <leader>sF to search files (including files ignored by git)
  pick.registry.customized_files_all = function()
    local cache_rg_config = vim.uv.os_getenv "RIPGREP_CONFIG_PATH" or ""
    -- Temporarily set the RIGPREP_CONFIG_PATH to ~/.config/nvim/.rg/files_all
    vim.uv.os_setenv("RIPGREP_CONFIG_PATH", vim.fn.stdpath "config" .. "/.rg/files_all")
    pick.builtin.files { tool = "rg" }
    -- Restore the original RIPGREP_CONFIG_PATH
    if cache_rg_config == "" then
      -- If RIPGREP_CONFIG_PATH was not set, remove it to avoid side effects
      vim.uv.os_unsetenv "RIPGREP_CONFIG_PATH"
    else
      vim.uv.os_setenv("RIPGREP_CONFIG_PATH", cache_rg_config)
    end
  end
  vim.keymap.set(
    "n",
    "<leader>sF",
    "<cmd>Pick customized_files_all<cr>",
    { desc = "[S]earch [F]iles (including ignored files)" }
  )

  -- Map <leader>sg to search grep
  pick.registry.customized_grep_live = function()
    local cache_rg_config = vim.uv.os_getenv "RIPGREP_CONFIG_PATH" or ""
    -- Temporarily set the RIGPREP_CONFIG_PATH to ~/.config/nvim/.rg/grep
    vim.uv.os_setenv("RIPGREP_CONFIG_PATH", vim.fn.stdpath "config" .. "/.rg/grep")
    pick.builtin.grep_live { tool = "rg" }
    -- Restore the original RIPGREP_CONFIG_PATH
    if cache_rg_config == "" then
      -- If RIPGREP_CONFIG_PATH was not set, remove it to avoid side effects
      vim.uv.os_unsetenv "RIPGREP_CONFIG_PATH"
    else
      vim.uv.os_setenv("RIPGREP_CONFIG_PATH", cache_rg_config)
    end
  end
  vim.keymap.set("n", "<leader>sg", "<cmd>Pick customized_grep_live<cr>", { desc = "[S]earch by [G]rep" })

  -- Map <leader>sG to search grep (including files ignored by git)
  pick.registry.customized_grep_live_all = function()
    local cache_rg_config = vim.uv.os_getenv "RIPGREP_CONFIG_PATH" or ""
    -- Temporarily set the RIGPREP_CONFIG_PATH to ~/.config/nvim/.rg/grep_all
    vim.uv.os_setenv("RIPGREP_CONFIG_PATH", vim.fn.stdpath "config" .. "/.rg/grep_all")
    pick.builtin.grep_live { tool = "rg" }
    -- Restore the original RIPGREP_CONFIG_PATH
    if cache_rg_config == "" then
      -- If RIPGREP_CONFIG_PATH was not set, remove it to avoid side effects
      vim.uv.os_unsetenv "RIPGREP_CONFIG_PATH"
    else
      vim.uv.os_setenv("RIPGREP_CONFIG_PATH", cache_rg_config)
    end
  end
  vim.keymap.set(
    "n",
    "<leader>sG",
    "<cmd>Pick customized_grep_live_all<cr>",
    { desc = "[S]earch by [G]rep (including ignored files)" }
  )

  -- Map <leader>ss to pick registry
  -- From: https://github.com/echasnovski/mini.pick/blob/c8f4ff0251ccb8c6a993ee0dee4e06d9c21a4b99/doc/mini-pick.txt#L1218
  pick.registry.registry = function()
    local items = vim.tbl_keys(MiniPick.registry)
    table.sort(items)
    local source = { items = items, name = "Registry", choose = function() end }
    local chosen_picker_name = MiniPick.start { source = source }
    if chosen_picker_name == nil then return end
    return MiniPick.registry[chosen_picker_name]()
  end
  vim.keymap.set("n", "<leader>ss", "<cmd>Pick registry<cr>", { desc = "[S]earch Regi[s]try" })
else
  vim.notify("mini.pick not found", vim.log.levels.WARN)
end
