local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  ------------
  -- MAIN
  ------------
  -- TS
  { "nvim-treesitter/nvim-treesitter" },

  -- LSP
  { "neovim/nvim-lspconfig" },

  -- Mason
  { "williamboman/mason.nvim",          VeryLazy = true },
  { "williamboman/mason-lspconfig.nvim" },

  -- CMP autocomplete
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/cmp-nvim-lua" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/nvim-cmp" },
  { "saadparwaiz1/cmp_luasnip" },
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.3",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Neotree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*"
  },

  -- trouble line
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }
  },

  -- TODO highlights
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },


  ------------
  -- LINTERS
  ------------
  { "jose-elias-alvarez/null-ls.nvim" },


  ------------
  -- MOTION
  ------------
  -- Flash
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end },
    },
  },

  -- Fast context comment
  {
    "numToStr/Comment.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    lazy = false
  },


  ------------
  -- UI
  ------------
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      -- "rcarriga/nvim-notify",
    }
  },

  ------------
  -- VISUAL
  ------------
  -- buffer line top
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    after = "catppuccin",
  },

  -- show colors
  { "norcalli/nvim-colorizer.lua" },

  -- icons for CMP
  { "onsails/lspkind.nvim" },

  -- pairs autoclose
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter"
  },

  -- html tags autoclose
  { "windwp/nvim-ts-autotag" },

  -- git left indicator
  { "lewis6991/gitsigns.nvim" },

  -- nvim bottom line
  { "nvim-lualine/lualine.nvim" },

  -- my keymapping helper
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
  },

  -- highlight other uses word
  { "RRethy/vim-illuminate" },

  -- adds indentation guides
  { "lukas-reineke/indent-blankline.nvim", main = "ibl" },

  -- show arguments functions
  { "folke/neodev.nvim" },


  ------------
  -- THEMES
  ------------
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000
  },
})
