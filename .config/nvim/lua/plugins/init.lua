return {
  {
    "stevearc/conform.nvim",
    -- event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = require("plugins.setup.mason").opts,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = require("plugins.setup.nvim-ts-context-commentstring").config,
      },
      {
        "windwp/nvim-ts-autotag",
        config = require("plugins.setup.nvim-ts-autotag").config,
      },
      {
        "RRethy/vim-illuminate",
        config = require("plugins.setup.vim-illuminate").config,
      },
      -- {
      --   "nvim-treesitter/nvim-treesitter-textobjects",
      --   config = require("plugins.setup.nvim-ts-textobjects").config,
      -- },
    },
    opts = require("plugins.setup.nvim-treesitter").opts,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = require("plugins.setup.nvim-tree").opts,
  },

  {
    "folke/flash.nvim",
    opts = require("plugins.setup.flash").opts,
    keys = require("plugins.setup.flash").keys,
  },

  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = require("plugins.setup.trouble").opts,
  },

  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    opts = require("plugins.setup.todo-comments").opts,
  },

  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile" },
    config = require("plugins.setup.lazygit").config(),
  },

  {
    "mg979/vim-visual-multi",
    branch = "master",
    init = require("plugins.setup.vim-visual-multi").init,
    keys = require("plugins.setup.vim-visual-multi").keys,
  },

  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewFileHistory",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
    },
  },

  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = require("plugins.setup.presistence").opts,
  },

  {
    "nvim-pack/nvim-spectre",
    cmd = { "Spectre" },
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = require("plugins.setup.markdown-preview").build,
  },

  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = require("plugins.setup.nvim-surround").config,
  },

  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    config = require("plugins.setup.codeium").config,
  },

  {
    "mfussenegger/nvim-dap",
    config = require("plugins.setup.nvim-dap").config,
    dependencies = {
      "rcarriga/nvim-dap-ui",
      config = require("plugins.setup.nvim-dap-ui").config,
    },
  },

  -- {
  --   "DreamMaoMao/yazi.nvim",
  --   keys = { { "<leader>gy", "<cmd>Yazi<CR>", desc = "Toggle Yazi" } },
  -- },

  {
    "brenoprata10/nvim-highlight-colors",
    config = require("plugins.setup.nvim-highlight-colors").config,
    event = "BufReadPost",
    dependencies = {
      -- disable NvChad colorize plugin
      "NvChad/nvim-colorizer.lua",
      enabled = false,
    },
  },

  {
    "utilyre/barbecue.nvim",
    -- cmd = { "Barbecue" },
    event = "BufReadPost",
    dependencies = { "SmiteshP/nvim-navic" },
    config = require("plugins.setup.barbecue").config,
  },

  {
    "kevinhwang91/nvim-ufo",
    -- cmd = { "Ufo" },
    event = "BufReadPost",
    dependencies = "kevinhwang91/promise-async",
    config = require("plugins.setup.nvim-ufo").config,
  },

  -- replacement for POSTMAN | INSOMNIA
  {
    "rest-nvim/rest.nvim",
    ft = { "http" },
    dependencies = {
      {
        "vhyrro/luarocks.nvim",
        priority = 1000,
        config = true,
        opts = { rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" } },
      },
    },
    config = require("plugins.setup.rest-nvim").config,
  },
}
