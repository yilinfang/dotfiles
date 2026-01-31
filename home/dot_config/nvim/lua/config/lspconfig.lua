-- lua/config/lspconfig.lua
-- LSP related configuration
-- NOTE: Deprecated

-- [[ Diagnostic ]]
-- Modified from https://github.com/echasnovski/nvim/blob/bbe5bb3d53592e8d96052e8650ad2bc023060fe5/plugin/10_options.lua#L146
local diagnostic_opts = {
  -- Define how diagnostic entries should be shown
  signs = false, -- NOTE: Disable signs like vscode
  underline = { severity = { min = 'HINT', max = 'ERROR' } },
  virtual_lines = false, -- Disable virtual_lines
  virtual_text = { severity = { min = 'HINT', max = 'ERROR' } },

  -- Don't update diagnostics when typing
  update_in_insert = false,
}
vim.diagnostic.config(diagnostic_opts)

-- [[ Keymappings ]]
-- Modifiled from kickstart.nvim (https://github.com/nvim-lua/kickstart.nvim/blob/3338d3920620861f8313a2745fd5d2be39f39534/init.lua#L495)
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'Configure LSP settings on attach',
  group = vim.api.nvim_create_augroup('lspconfig-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- Rename the variable under your cursor.
    --  Most Language Servers support renaming across files, etc.
    map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

    -- Execute a code action, usually your cursor needs to be on top of an error
    -- or a suggestion from your LSP for this to activate.
    map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

    -- Find references for the word under your cursor.
    map('grr', vim.lsp.buf.references, '[G]oto [R]eferences')

    -- Jump to the implementation of the word under your cursor.
    --  Useful when your language has ways of declaring types without an actual implementation.
    map('gri', vim.lsp.buf.implementation, '[G]oto [I]mplementation')

    -- Jump to the definition of the word under your cursor.
    --  This is where a variable was first declared, or where a function is defined, etc.
    --  To jump back, press <C-t>.
    map('grd', vim.lsp.buf.definition, '[G]oto [D]efinition')

    -- WARN: This is not Goto Definition, this is Goto Declaration.
    --  For example, in C this would take you to the header.
    map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    -- Fuzzy find all the symbols in your current document.
    --  Symbols are things like variables, functions, types, etc.
    map('gO', vim.lsp.buf.document_symbol, 'Open Document Symbols')

    -- Fuzzy find all the symbols in your current workspace.
    --  Similar to document symbols, except searches over your entire project.
    map('gW', vim.lsp.buf.workspace_symbol, 'Open Workspace Symbols')

    -- Jump to the type of the word under your cursor.
    --  Useful when you're not sure what type a variable is and you want to see
    --  the definition of its *type*, not where it was *defined*.
    map('grt', vim.lsp.buf.type_definition, '[G]oto [T]ype Definition')

    -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
    ---@param client vim.lsp.Client
    ---@param method vim.lsp.protocol.Method
    ---@param bufnr? integer some lsp support methods only in specific files
    ---@return boolean
    local function client_supports_method(client, method, bufnr)
      if vim.fn.has('nvim-0.11') == 1 then
        return client:supports_method(method, bufnr)
      else
        return client.supports_method(method, { bufnr = bufnr })
      end
    end

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if
      client
      and client_supports_method(
        client,
        vim.lsp.protocol.Methods.textDocument_documentHighlight,
        event.buf
      )
    then
      local highlight_augroup =
        vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({
            group = 'kickstart-lsp-highlight',
            buffer = event2.buf,
          })
        end,
      })
    end

    -- The following code creates a keymap to toggle inlay hints in your
    -- code, if the language server you are using supports them
    --
    -- This may be unwanted, since they displace some of your code
    if
      client
      and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
    then
      map(
        '<leader>th',
        function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
        end,
        '[T]oggle Inlay [H]ints'
      )
    end
  end,
})

-- [[ Setup LSPs ]]
-- If `lua-language-server` is installed, set it up
if vim.fn.executable('lua-language-server') == 1 then
  vim.lsp.config('lua_ls', {
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
        format = { enable = false }, -- Disable formatting since we use `stylua`
        hint = {
          enable = true,
          arrayIndex = 'Disable',
        },
        runtime = {
          version = 'LuaJIT',
        },
        telemetry = { enable = false },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
            '${3rd}/luv/library',
          },
        },
      },
    },
  })
  vim.lsp.enable('lua_ls')
end

-- If `ruff is installed`, set it up
if vim.fn.executable('ruff') == 1 then
  vim.lsp.config('ruff', {})
  vim.lsp.enable('ruff')
end

-- If `pyright` is installed, set it up
if vim.fn.executable('pyright') == 1 then
  vim.lsp.config('pyright', {
    settings = {
      pyright = {
        disableOrganizeImports = true, -- Using `Ruff`'s import organizer
      },
      python = {
        analysis = {
          diagnosticMode = 'workspace',
        },
      },
    },
  })
  vim.lsp.enable('pyright')
  -- HACK: Disable hover capability from `Ruff`
  --  This is to avoid conflicts with `Pyright`'s hover capability.
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('disable-ruff-hover-lsp-attach', { clear = true }),
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client == nil then return end
      if client.name == 'ruff' then
        -- Disable hover in favor of `Pyright`
        client.server_capabilities.hoverProvider = false
      end
    end,
    desc = 'LSP: Disable hover capability from Ruff',
  })
end

-- if `bash-language-server` is installed, set it up
if vim.fn.executable('bash-language-server') == 1 then
  vim.lsp.config('bashls', {})
  vim.lsp.enable('bashls')
end
