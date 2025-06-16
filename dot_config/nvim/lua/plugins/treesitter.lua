-- Highlight, edit, and navigate code
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master", -- HACK: Set the branch to master
  lazy = false, -- HACK: Load nvim-treesitter immediately
  init = function(plugin) -- HACK: Add nvim-treesitter queries to the rtp
    -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
    -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
    -- no longer trigger the **nvim-treeitter** module to be loaded in time.
    -- Luckily, the only thins that those plugins need are the custom queries, which we make available
    -- during startup.
    -- CODE FROM LazyVim (thanks folke!) https://github.com/LazyVim/LazyVim/commit/1e1b68d633d4bd4faa912ba5f49ab6b8601dc0c9
    require("lazy.core.loader").add_to_rtp(plugin)
    pcall(require, "nvim-treesitter.query_predicates")
  end,
  build = ":TSUpdate",
  main = "nvim-treesitter.configs", -- Sets main module to use for opts
  -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
  opts = {
    ensure_installed = { -- HACK: Treesitter parsers
      "bash",
      "diff",
      "fish",
      "html",
      "json",
      "lua",
      "luadoc",
      "markdown",
      "markdown_inline",
      "python",
      "toml",
      "query",
      "regex",
      "vim",
      "vimdoc",
      "yaml",
    },
    -- Autoinstall languages that are not installed
    auto_install = true,
    highlight = {
      enable = true,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { "ruby" },
    },
    indent = { enable = true, disable = { "ruby" } },
  },
}
