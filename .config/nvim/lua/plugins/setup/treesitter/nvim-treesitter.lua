return {
  opts = {
    ensure_installed = {
      "vim",
      "lua",
      "vimdoc",
      "html",
      "http",
      "css",
      "javascript",
      "typescript",
      "tsx",
      "markdown",
      "markdown_inline",
      "go",
      "gomod",
      "gosum",
      "templ",
    },

    indent = {
      enable = true,
      -- disable = { "python" },
    },

    incremental_selection = {
      enable = true,
      keymaps = {
        -- init_selection = "<CR>",
        node_incremental = "<CR>",
        node_decremental = "<BS>",
      },
    },
  },
}
