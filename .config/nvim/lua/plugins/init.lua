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

  { -- FILE EXPLORER
    "nvim-tree/nvim-tree.lua",
    opts = require("plugins.setup.nvim-tree").opts,
  },

  { -- NAVIGATION
    "folke/flash.nvim",
    opts = require("plugins.setup.flash").opts,
    keys = require("plugins.setup.flash").keys,
  },

  { -- BETTER QUICKFIX
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = require("plugins.setup.trouble").opts,
  },

  { -- TODO
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    opts = require("plugins.setup.todo-comments").opts,
  },

  { -- GIT
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile" },
    config = require("plugins.setup.lazygit").config(),
  },

  { -- MULTI-CURSOR
    "mg979/vim-visual-multi",
    -- event = "BufReadPost",
    branch = "master",
    init = require("plugins.setup.vim-visual-multi").init,
    keys = require("plugins.setup.vim-visual-multi").keys,
  },

  { -- DIFF VIEW
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

  { -- SESSIONS
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = require("plugins.setup.presistence").opts,
  },

  { -- SEARCH & REPLACE
    "nvim-pack/nvim-spectre",
    cmd = { "Spectre" },
  },

  { -- PREVIE .md
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = require("plugins.setup.markdown-preview").build,
  },

  { -- PRO REDEFINITION
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = require("plugins.setup.nvim-surround").config,
  },

  { -- AI
    "Exafunction/codeium.vim",
    event = "BufEnter",
    config = require("plugins.setup.codeium").config,
  },

  { -- DEBUG
    "mfussenegger/nvim-dap",
    config = require("plugins.setup.nvim-dap").config,
    dependencies = {
      "rcarriga/nvim-dap-ui",
      config = require("plugins.setup.nvim-dap-ui").config,
    },
  },

  -- { -- FILE MANAGER
  --   "DreamMaoMao/yazi.nvim",
  --   keys = { { "<leader>gy", "<cmd>Yazi<CR>", desc = "Toggle Yazi" } },
  -- },

  { -- HIGHLIGHT COLORS
    "brenoprata10/nvim-highlight-colors",
    -- event = "BufReadPost",
    cmd = { "HighlightColors" },
    config = require("plugins.setup.nvim-highlight-colors").config,
  },

  { -- COLOR PICKER & HIGHLIGHT COLORS
    "uga-rosa/ccc.nvim",
    event = "BufReadPost",
    -- cmd = { "CccConvert", "CccPick" },
    config = require("plugins.setup.ccc").config,
    dependencies = {
      -- INFO: disable NvChad colorize plugin
      "NvChad/nvim-colorizer.lua",
      enabled = false,
    },
  },

  { -- lua > plugins > init.lua > []return
    "utilyre/barbecue.nvim",
    event = "BufReadPost",
    dependencies = { "SmiteshP/nvim-navic" },
    config = require("plugins.setup.barbecue").config,
  },

  { -- FOLDERS
    "kevinhwang91/nvim-ufo",
    event = "BufReadPost",
    dependencies = "kevinhwang91/promise-async",
    config = require("plugins.setup.nvim-ufo").config,
  },

  { -- NVIM "POSTMAN"
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

  { -- ZEN MODE
    "folke/zen-mode.nvim",
    cmd = { "ZenMode" },
    opts = require("plugins.setup.zen-mode").opts,
    dependencies = {
      "folke/twilight.nvim",
      opts = require("plugins.setup.zen-mode").twilight_opts,
    },
  },

  { -- SCREENSHOTS
    "mistricky/codesnap.nvim",
    build = "make",
    cmd = { "CodeSnap", "CodeSnapSave", "CodeSnapHighlight", "CodeSnapSaveHighlight" },
    -- keys = require("plugins.setup.codesnap").keys,
    opts = require("plugins.setup.codesnap").opts,
  },
}
