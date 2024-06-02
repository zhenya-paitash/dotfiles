return {
  { -- FORMATTERS
    "stevearc/conform.nvim",
    -- event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  { -- LSP
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  { -- LSP INSTALLER
    "williamboman/mason.nvim",
    opts = require("plugins.setup.mason").opts,
  },

  { -- TREESITTER
    "nvim-treesitter/nvim-treesitter",
    opts = require("plugins.setup.nvim-treesitter").opts,
    dependencies = {
      { -- CONTEXT COMMENT
        "folke/ts-comments.nvim",
        enabled = vim.fn.has "nvim-0.10.0" == 1,
        -- event = "VeryLazy",
        opts = {},
      },
      { -- AUTOCLOSE & AUTORENAME HTML TAGS
        "windwp/nvim-ts-autotag",
        config = require("plugins.setup.nvim-ts-autotag").config,
      },
      { -- HIGHLIGHT VARS UNDER CURSOR
        "RRethy/vim-illuminate",
        config = require("plugins.setup.vim-illuminate").config,
      },
      { -- SYNTAX AWARE TEXT-OBJECTS
        "nvim-treesitter/nvim-treesitter-textobjects",
        config = require("plugins.setup.nvim-ts-textobjects").config,
      },
    },
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
    cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile" },
    config = require("plugins.setup.lazygit").config(),
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  { -- MULTI-CURSOR
    "mg979/vim-visual-multi",
    -- event = "BufReadPost",
    branch = "master",
    keys = require("plugins.setup.vim-visual-multi").keys,
    init = require("plugins.setup.vim-visual-multi").init,
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

  { -- PREVIEW .md
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
    dependencies = { -- DEBUG UI
      "rcarriga/nvim-dap-ui",
      config = require("plugins.setup.nvim-dap-ui").config,
    },
  },

  { -- FILE MANAGER
    "DreamMaoMao/yazi.nvim",
    keys = { { "<leader>gy", "<cmd>Yazi<CR>", desc = "Toggle Yazi" } },
  },

  { -- HIGHLIGHT COLORS
    "brenoprata10/nvim-highlight-colors",
    -- event = "BufReadPost",
    cmd = { "HighlightColors" },
    config = require("plugins.setup.nvim-highlight-colors").config,
  },

  { -- HIGHLIGHT COLORS & COLOR PICKER
    "uga-rosa/ccc.nvim",
    event = "BufReadPost",
    -- cmd = { "CccConvert", "CccPick" },
    config = require("plugins.setup.ccc").config,
    dependencies = {
      -- INFO: disable NvChad colorize plugin
      { "NvChad/nvim-colorizer.lua", enabled = false },
    },
  },

  { -- LSP CONTEXT: lua > plugins > init.lua > []return
    "utilyre/barbecue.nvim",
    event = "BufReadPost",
    config = require("plugins.setup.barbecue").config,
    dependencies = { "SmiteshP/nvim-navic" },
  },

  { -- FOLDERS
    "kevinhwang91/nvim-ufo",
    event = "BufReadPost",
    config = require("plugins.setup.nvim-ufo").config,
    dependencies = "kevinhwang91/promise-async",
  },

  { -- HTTP CLIENT
    "rest-nvim/rest.nvim",
    ft = { "http" },
    config = require("plugins.setup.rest-nvim").config,
    dependencies = {
      "vhyrro/luarocks.nvim",
      priority = 1000,
      config = true,
      opts = { rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" } },
    },
  },

  { -- ZEN MODE
    "folke/zen-mode.nvim",
    cmd = { "ZenMode" },
    opts = require("plugins.setup.zen-mode").opts,
    dependencies = { -- DIMMING INACTIVE CODE
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

  { -- NOTES
    "epwalsh/obsidian.nvim",
    event = {
      "BufReadPre /home/zh/obsidian/**.md",
      "BufNewFile /home/zh/obsidian/**.md",
    },
    keys = require("plugins.setup.obsidian").keys,
    config = require("plugins.setup.obsidian").config,
    -- dependencies = { "nvim-lua/plenary.nvim" },
  },

  { -- UI
    "folke/noice.nvim",
    event = "VeryLazy",
    config = require("plugins.setup.ui").config,
    dependencies = {
      "MunifTanjim/nui.nvim",
      -- "rcarriga/nvim-notify",
    },
  },

  { -- BEST PRACTICE
    "m4xshen/hardtime.nvim",
    event = "VeryLazy",
    opts = {
      -- WARN: by default this plugin disable mousescroll
      -- disable_mouse = false,
    },
  },

  -- { -- MARKS BETTER ?
  --   "ThePrimeagen/harpoon",
  --   event = "VeryLazy",
  --   setup = {},
  --   config = require("plugins.setup.harpoon").config,
  -- },
}
