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
      { -- TS TEXT-OBJECTS MANIPULATE
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = "BufReadPost",
        config = require("plugins.setup.nvim-ts-textobjects").config,
        dependencies = { -- REGULAR MANIPULATE
          "echasnovski/mini.nvim",
          version = false,
          config = require("plugins.setup.mini-nvim").config,
        },
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
    event = "BufReadPost",
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

  -- { -- SEARCH & REPLACE
  --   "nvim-pack/nvim-spectre",
  --   cmd = { "Spectre" },
  -- },

  { -- SEARCH & REPLACE (NEW)
    "MagicDuck/grug-far.nvim",
    config = require("plugins.setup.grug-far").config,
  },

  -- { -- MARKDOWN PREVIEW
  --   "iamcco/markdown-preview.nvim",
  --   cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
  --   ft = { "markdown" },
  --   build = require("plugins.setup.markdown-preview").build,
  --   init = require("plugins.setup.markdown-preview").init,
  -- },

  { -- MARKDOWN PREVIEW in neovim
    "OXY2DEV/markview.nvim",
    ft = "markdown",
    -- setup = require("plugins.setup.markview").config,
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
    -- FIX(issue): https://github.com/Exafunction/codeium.vim/issues/376#issuecomment-2159643405
    -- FIX: the latest update breaks the plugin. Need revert to v1.8.37 289eb72
    version = "1.8.37",
    -- commit = "289eb72",
  },

  { -- DEBUG
    "mfussenegger/nvim-dap",
    config = require("plugins.setup.nvim-dap").config,
    dependencies = { -- DEBUG UI
      "rcarriga/nvim-dap-ui",
      dependencies = { "nvim-neotest/nvim-nio" },
      config = require("plugins.setup.nvim-dap-ui").config,
    },
  },

  { -- FILE MANAGER
    "DreamMaoMao/yazi.nvim",
    keys = { { "<leader>gy", "<cmd>Yazi<CR>", desc = "Toggle Yazi" } },
  },

  -- { -- HIGHLIGHT COLORS (support `tailwindcss` colors)
  --   "brenoprata10/nvim-highlight-colors",
  --   -- event = "BufReadPost",
  --   cmd = { "HighlightColors" },
  --   config = require("plugins.setup.nvim-highlight-colors").config,
  -- },

  -- { -- HIGHLIGHT COLORS & COLOR PICKER
  --   "uga-rosa/ccc.nvim",
  --   event = "BufReadPost",
  --   -- cmd = { "CccConvert", "CccPick" },
  --   config = require("plugins.setup.ccc").config,
  --   dependencies = {
  --     -- INFO: disable NvChad colorize plugin
  --     { "NvChad/nvim-colorizer.lua", enabled = false },
  --   },
  -- },

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

  -- { -- HTTP CLIENT
  --   "rest-nvim/rest.nvim",
  --   ft = { "http" },
  --   config = require("plugins.setup.rest-nvim").config,
  --   dependencies = {
  --     "vhyrro/luarocks.nvim",
  --     priority = 1000,
  --     config = true,
  --     opts = { rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" } },
  --   },
  -- },

  { -- HTTP CLIENT
    "mistweaverco/kulala.nvim",
    config = require("plugins.setup.rest-kulala").config,
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
    -- event = {
    --   "BufReadPre /home/zh/obsidian/**.md",
    --   "BufNewFile /home/zh/obsidian/**.md",
    -- },
    -- ft = { "markdown" },
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
    opts = require("plugins.setup.hardtime").opts,
  },

  -- { -- MARKS BETTER ?
  --   "ThePrimeagen/harpoon",
  --   event = "VeryLazy",
  --   setup = {},
  --   config = require("plugins.setup.harpoon").config,
  -- },

  -- { -- GAME PRACTICE
  --   "ThePrimeagen/vim-be-good",
  --   cmd = { "VimBeGood" },
  -- },

  -- { -- TYPING PRACTICE
  --   "kwakzalver/duckytype.nvim",
  --   cmd = { "DuckyType" },
  --   config = require("plugins.setup.duckytype").config,
  -- },

  { -- FZF
    -- init: `:Telescope load_extension fzf` OR go to `$HOME/.local/share/nvim/lazy/telescope-fzf-native.nvim` and run `make`
    "nvim-telescope/telescope-fzf-native.nvim",
    event = "VeryLazy",
    -- run = "make",
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
    config = function()
      require("telescope").load_extension "fzf"
    end,
  },

  -- { -- CODE ANNOTATION
  --   "danymat/neogen",
  --   version = "*", -- only `stable` version plugin
  --   keys = require("plugins.setup.neogen").keys,
  --   config = require("plugins.setup.neogen").config,
  -- },

  { -- DATABASE
    "tpope/vim-dadbod",
    cmd = {
      "DB",
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    dependencies = {
      { -- DATABASE UI
        "kristijanhusak/vim-dadbod-ui",
        init = require("plugins.setup.dadbod").UI.init,
      },
      { -- DATABASE AUTOCOMPLETION
        "kristijanhusak/vim-dadbod-completion",
        ft = { "sql", "mysql", "plsql" },
      },
    },
  },

  { -- LEETCODE
    "kawre/leetcode.nvim",
    lazy = "leetcode.nvim" ~= vim.fn.argv()[1],
    -- opts = { arg = "leetcode.nvim" },
    opts = require("plugins.setup.leetcode").opts,
  },

  -- { -- NOTE ALTERNATIVE
  --   "nvim-neorg/neorg",
  --   run = ":Neorg sync-parsers",
  --   dependencies = { "luarocks.nvim" },
  --   lazy = false,
  --   version = "*",
  --   config = require("plugins.setup.neorg").config,
  -- },

  -- { -- TESTS
  --   "nvim-neotest/neotest",
  --   dependencies = {
  --     "nvim-neotest/nvim-nio",
  --     "nvim-lua/plenary.nvim",
  --     -- "antoinemadec/FixCursorHold.nvim",  -- WARN:  This plugin is not needed after neovim/neovim#20198
  --   },
  -- },

  { -- SHOW KEYS
    "nvchad/showkeys",
    cmd = "ShowkeysToggle",
    opts = {
      -- timeout = 1,
      maxkeys = 5,
      position = "top-right",
      show_count = true,
    },
  },

  -- { -- AUCTOCOMPLETE
  --   "saghen/blink.cmp",
  --   lazy = false,
  --   version = "v0.*",
  --   opts = require("plugins.setup.blink-cmp").opts,
  --   dependencies = {
  --     "rafamadriz/friendly-snippets",
  --     { "hrsh7th/nvim-cmp", enabled = false }, -- disable default `nvim-cmp`
  --   },
  -- },
}
