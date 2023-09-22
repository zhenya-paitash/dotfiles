local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Motions
	{ "phaazon/hop.nvim" },

  -- Neotree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
	},

  -- TS
	{ "nvim-treesitter/nvim-treesitter" },

  -- LSP
	{ "neovim/nvim-lspconfig" },

  -- :autocomplete
  -- https://github.com/hrsh7th/nvim-cmp
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/nvim-cmp" },

  -- :themes
  -- https://github.com/joshdick/onedark.vim
  { "joshdick/onedark.vim" },
  { "matsuuu/pinkmare" },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  -- Mason
  {  "williamboman/mason.nvim" },

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.3',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  -- Linters
  { "jose-elias-alvarez/null-ls.nvim" }
})
