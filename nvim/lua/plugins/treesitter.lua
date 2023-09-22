require'nvim-treesitter.configs'.setup {
  ensure_installed = {
	  "c",
	  "lua",
	  "vim",
	  "javascript",
	  "typescript",
	  "tsx"
  },

  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
}
