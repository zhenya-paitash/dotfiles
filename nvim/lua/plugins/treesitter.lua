require "nvim-treesitter.configs".setup {
  ensure_installed = {
    "c",
    "lua",
    "vim",
    "javascript",
    "typescript",
    "tsx",
    "html",
    "css",
    "scss",
    "markdown",
    "markdown_inline",
  },

  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
  autotag = {
    enable = true,
    enable_rename = true,
    enable_close = true,
    enable_close_on_slash = true,
  },
}
