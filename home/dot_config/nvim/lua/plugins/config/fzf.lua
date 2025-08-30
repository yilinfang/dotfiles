-- lua/plugins/config/fzf.lua
-- Configuration for `fzf-lua`

local fzf = require "fzf-lua"

-- [[ Setup `fzf-lua` ]]
local opts = {
  previewers = {
    builtin = {
      -- HACK: Disable image previewer
      extensions = nil,
      snacks_image = { enabled = false },
    },
  },
}

-- HACK: Customize `fd` command for files and complete
-- NOTE: Modify `$XDG_CONFIG_HOME/fd/ignore` to ignore files and directories
local fd_default_cmd = ""
if vim.fn.executable "fdfind" == 1 then
  fd_default_cmd = "fdfind "
elseif vim.fn.executable "fd" == 1 then
  fd_default_cmd = "fd "
else
  vim.notify("fzf-lua: `fd` or `fdfind` not found", vim.log.levels.WARN)
end
--
if fd_default_cmd ~= "" then -- If `fd` or `fdfind` is available
  opts.files = opts.files or {}
  -- Options from https://github.com/ibhagwan/fzf-lua/blob/main/lua/fzf-lua/defaults.lua
  opts.files.cmd = fd_default_cmd .. "--color=never --type f --type l "
  opts.files.hidden = true
  opts.files.follow = false
  opts.files.no_ignore = false
  opts.files.toggle_hidden_flag = "--hidden"
  opts.files.toggle_follow_flag = "--follow"
  opts.files.toggle_ignore_flag = "--no-ignore-vcs" -- Only ignore .gitignore
  opts.complete_path = opts.complete_path or {}
  -- Options from https://github.com/ibhagwan/fzf-lua/blob/main/lua/fzf-lua/complete.lua
  opts.complete_path.cmd = fd_default_cmd
    .. "--color=never --strip-cwd-prefix --type f --type l --hidden --no-ignore-vcs " -- Show hidden and ignored files when completing path
  opts.complete_file = opts.complete_file or {}
  -- Options from https://github.com/ibhagwan/fzf-lua/blob/main/lua/fzf-lua/complete.lua
  opts.complete_file.cmd = fd_default_cmd
    .. "--color=never --strip-cwd-prefix --type f --type l --hidden --no-ignore-vcs " -- Show hidden and ignored files when completing file
end

-- HACK: Customized `rg` command for grep
local rg_default_cmd = ""
if vim.fn.executable "rg" == 1 then
  rg_default_cmd = "rg "
else
  vim.notify("fzf-lua: `rg` not found", vim.log.levels.WARN)
end
if rg_default_cmd ~= "" then -- If `rg` is available
  opts.grep = opts.grep or {}
  -- Options from https://github.com/ibhagwan/fzf-lua/blob/main/lua/fzf-lua/defaults.lua
  opts.grep.cmd = rg_default_cmd
    .. "--color=never --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e "
  -- NOTE: Modify `$XDG_CONFIG_HOME/nvim/.rg/grep` to customize the ripgrep configuration
  opts.grep.RIPGREP_CONFIG_PATH = vim.fn.stdpath "config" .. "/.ripgreprc"
  opts.grep.hidden = true
  opts.grep.follow = false
  opts.grep.no_ignore = false
  opts.grep.toggle_hidden_flag = "--hidden"
  opts.grep.toggle_follow_flag = "--follow"
  opts.grep.toggle_ignore_flag = "--no-ignore-vcs" -- Only ignore .gitignore
end

fzf.setup(opts)

-- Registration with fzf-lua
-- HACK: Customize the UI select appearance
fzf.register_ui_select(function(ui_select_opts)
  ui_select_opts.prompt = "> "
  local title = "Select"
  return {
    winopts = {
      title = " " .. title .. " ",
    },
  }
end)

-- HACK: Create an autocmd to redraw the fzf window when the neovim window is resized
vim.api.nvim_create_autocmd("VimResized", {
  desc = "Redraw fzf window on resize",
  group = vim.api.nvim_create_augroup("fzflua-redraw", { clear = true }),
  pattern = "*",
  callback = function() fzf.redraw() end,
})

-- [[ Keymaps ]]
vim.keymap.set("n", "<leader><leader>", "<cmd>FzfLua global<cr>", { desc = "[' '] Search Global" })
vim.keymap.set("n", "<leader>/", "<cmd>FzfLua lgrep_curbuf<cr>", { desc = "['/'] Grep Current Buffer" })
vim.keymap.set("n", "<leader>sf", "<cmd>FzfLua files<cr>", { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sg", "<cmd>FzfLua live_grep<cr>", { desc = "[S]earch [G]rep" })
vim.keymap.set("n", "<leader>sh", "<cmd>FzfLua helptags<cr>", { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sr", "<cmd>FzfLua resume<cr>", { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>sk", "<cmd>FzfLua keymaps<cr>", { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>st", "<cmd>FzfLua treesitter<cr>", { desc = "[S]earch [T]reesitter Nodes" })
vim.keymap.set("n", "<leader>s.", "<cmd>FzfLua oldfiles<cr>", { desc = "[S]earch Old Files (['.'] for repeat)" })
vim.keymap.set("n", "<leader>sm", "<cmd>FzfLua marks<cr>", { desc = "[S]earch [M]arks" })
vim.keymap.set("n", "<leader>sj", "<cmd>FzfLua jumps<cr>", { desc = "[S]earch [J]umplist" })
vim.keymap.set("n", "<leader>ss", "<cmd>FzfLua builtin<cr>", { desc = "[S]earch Picker[s]" })
vim.keymap.set("i", "<C-f>", [[<cmd>FzfLua complete_path winopts.title="\ Path\ "<cr>]], { desc = "Complete Path" })

-- [[ LSP pickers ]]
-- NOTE: Only available when LSP is attached
--  It will override some of the default LSP keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Configure LSP pickers on attach",
  group = vim.api.nvim_create_augroup("fzflua-lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end
    map("<leader>sd", "<cmd>FzfLua lsp_document_diagnostics<cr>", "[S]earch [D]iagnostics")
    map("<leader>sD", "<cmd>FzfLua lsp_workspace_diagnostics<cr>", "[S]earch Workspace [D]iagnostics")
    map("grr", "<cmd>FzfLua lsp_references<cr>", "[G]oto [R]eferences")
    -- Jump to the implementation of the word under cursor
    map("gri", "<cmd>FzfLua lsp_implementations<cr>", "[G]oto [I]mplementation")
    -- Jump to the definition of the word under cursor
    map("grd", "<cmd>FzfLua lsp_definitions<cr>", "[G]oto [D]efinition")
    -- Jump to the declaration of the word under cursor
    map("grD", "<cmd>FzfLua lsp_declarations<cr>", "[G]oto [D]eclaration")
    -- Jump to the type definition of the word under cursor
    map("grt", "<cmd>FzfLua lsp_typedefs<cr>", "[G]oto [T]ype Definition")
    -- Fuzzy find All Code Actions
    map("gra", "<cmd>FzfLua lsp_code_actions<cr>", "[G]oto Code [A]ctions")
    -- Fuzzy find all the symbols in current document
    map("gO", "<cmd>FzfLua lsp_document_symbols<cr>", "Open Document Symbols")
    -- Fuzzy find all the symbols in current workspace
    map("gW", "<cmd>FzfLua lsp_live_workspace_symbols<cr>", "Open Workspace Symbols")
  end,
})
