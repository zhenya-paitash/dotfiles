return {
  opts = {
    ensure_installed = {
      "vim",
      "lua",
      "vimdoc",
      "html",
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
      -- disable = {
      --   "python"
      -- },
    },

    -- windwp/nvim-ts-autotag
    autotag = {
      enable = true,
      enable_rename = true,
      enable_close = true,
      enable_close_on_slash = false,
      filetypes = { "html", "xml", "javascriptreact", "typescriptreact", "jsx", "tsx", "astro", "vue" },
    },
  },
}
