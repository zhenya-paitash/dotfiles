return {

  ------------------------------------------------------------------------------
  -- LSP и Форматирование
  --
  -- @directory [ configs/conform , configs/lspconfig , plugins/setup/lsp/* ]
  --
  -- @plugins
  -- `stevearc/conform.nvim`: Форматирование кода.
  -- `neovim/nvim-lspconfig`: Конфигурация LSP.
  -- `williamboman/mason.nvim`: Установщик LSP и других инструментов.
  ------------------------------------------------------------------------------

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
    opts = require("plugins.setup.lsp.mason").opts,
  },

  ------------------------------------------------------------------------------
  -- Работа с деревом и синтаксисом
  --
  -- @directory [ plugins/setup/treesitter/* ]
  --
  -- @plugins
  -- `nvim-treesitter/nvim-treesitter`: Дерево синтаксиса и подсветка.
  -- - `folke/ts-comments.nvim`: Контекстные комментарии.
  -- - `windwp/nvim-ts-autotag`: Автозакрытие HTML-тегов.
  -- - `RRethy/vim-illuminate`: Подсветка переменных под курсором.
  -- - `nvim-treesitter/nvim-treesitter-textobjects`: Работа с текстовыми объектами.
  -- - - `echasnovski/mini.nvim`: Работа с текстовыми объектами.
  ------------------------------------------------------------------------------

  { -- TREESITTER
    "nvim-treesitter/nvim-treesitter",
    opts = require("plugins.setup.treesitter.nvim-treesitter").opts,
    dependencies = {
      { -- CONTEXT COMMENT
        "folke/ts-comments.nvim",
        enabled = vim.fn.has "nvim-0.10.0" == 1,
        opts = {},
      },
      { -- AUTOCLOSE & AUTORENAME HTML TAGS
        "windwp/nvim-ts-autotag",
        event = "BufReadPre",
        init = require("plugins.setup.treesitter.nvim-ts-autotag").init,
      },
      { -- HIGHLIGHT VARS UNDER CURSOR
        "RRethy/vim-illuminate",
        config = require("plugins.setup.treesitter.vim-illuminate").config,
      },
      { -- TS TEXT-OBJECTS MANIPULATE
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = "BufReadPost",
        config = require("plugins.setup.treesitter.nvim-ts-textobjects").config,
        dependencies = { -- REGULAR MANIPULATE
          "echasnovski/mini.nvim",
          version = false,
          config = require("plugins.setup.treesitter.mini-nvim").config,
        },
      },
    },
  },

  ------------------------------------------------------------------------------
  -- Файловая система
  --
  -- @directory [ plugins/setup/filesystem/* ]
  --
  -- @plugins
  -- `nvim-tree/nvim-tree.lua`: Файловый менеджер.
  -- `DreamMaoMao/yazi.nvim`: Альтернативный файловый менеджер.
  -- `stevearc/oil.nvim`: Работа с буферами.
  ------------------------------------------------------------------------------

  { -- FILE EXPLORER
    "nvim-tree/nvim-tree.lua",
    opts = require("plugins.setup.filesystem.nvim-tree").opts,
  },

  { -- FILE MANAGER
    "DreamMaoMao/yazi.nvim",
    keys = { { "<leader>gy", "<cmd>Yazi<CR>", desc = "Toggle Yazi" } },
  },

  { -- BUFFER FILE EXPLORER
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = require("plugins.setup.filesystem.oil").opts,
  },

  ------------------------------------------------------------------------------
  -- Навигация
  --
  -- @directory [ plugins/setup/navigation/* ]
  --
  -- @plugins
  -- `folke/flash.nvim`: Улучшенная навигация.
  -- `kylechui/nvim-surround`: Улучшенное редактирование окружений.
  -- `mg979/vim-visual-multi`: Улучшенная многокурсорная навигация.
  -- `nvim-telescope/telescope-fzf-native.nvim`: Улучшенный поиск в telescope с fzf.
  ------------------------------------------------------------------------------

  { -- NAVIGATION
    "folke/flash.nvim",
    opts = require("plugins.setup.navigation.flash").opts,
    keys = require("plugins.setup.navigation.flash").keys,
  },

  { -- PRO REDEFINITION
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = require("plugins.setup.navigation.nvim-surround").config,
  },

  { -- MULTI-CURSOR
    "mg979/vim-visual-multi",
    -- event = "BufReadPost",
    branch = "master",
    keys = require("plugins.setup.navigation.vim-visual-multi").keys,
    init = require("plugins.setup.navigation.vim-visual-multi").init,
  },

  { -- FZF
    -- INFO: `:Telescope load_extension fzf` OR go to `$HOME/.local/share/nvim/lazy/telescope-fzf-native.nvim` and run `make`
    "nvim-telescope/telescope-fzf-native.nvim",
    event = "VeryLazy",
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
    config = function()
      require("telescope").load_extension "fzf"
    end,
  },

  ------------------------------------------------------------------------------
  -- Интерфейс
  --
  -- @directory [ plugins/setup/interface/* ]
  --
  -- @plugins
  -- `folke/noice.nvim`: UI улучшения.
  -- `folke/trouble.nvim`: Улучшенная работа с quickfix.
  -- `folke/todo-comments.nvim`: TODO-комментарии.
  -- `kevinhwang91/nvim-ufo`: Улучшенная работа с фолдерами.
  -- `folke/persistence.nvim`: Сохранение/Восстановление состояния.
  ------------------------------------------------------------------------------

  { -- UI
    "folke/noice.nvim",
    event = "VeryLazy",
    config = require("plugins.setup.interface.ui").config,
    dependencies = {
      "MunifTanjim/nui.nvim",
      -- "rcarriga/nvim-notify",
    },
  },

  { -- BETTER QUICKFIX
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = require("plugins.setup.interface.trouble").opts,
  },

  { -- TODO
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPost",
    opts = require("plugins.setup.interface.todo-comments").opts,
  },

  { -- FOLDERS
    "kevinhwang91/nvim-ufo",
    event = "BufReadPost",
    config = require("plugins.setup.interface.nvim-ufo").config,
    dependencies = "kevinhwang91/promise-async",
  },

  { -- SESSIONS
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = require("plugins.setup.interface.presistence").opts,
  },

  ------------------------------------------------------------------------------
  -- Поиск и замена
  --
  -- @directory [ plugins/setup/search/* ]
  --
  -- @plugins
  -- `MagicDuck/grug-far.nvim`: Поиск и замена.
  ------------------------------------------------------------------------------

  { -- SEARCH & REPLACE (NEW)
    "MagicDuck/grug-far.nvim",
    config = require("plugins.setup.search.grug-far").config,
  },

  ------------------------------------------------------------------------------
  -- Git и работа с версиями
  --
  -- @directory [ plugins/setup/git/* ]
  --
  -- @plugins
  -- `kdheepak/lazygit.nvim`: Интеграция с LazyGit.
  -- `sindrets/diffview.nvim`: Просмотр изменений.
  ------------------------------------------------------------------------------

  { -- GIT
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile" },
    config = require("plugins.setup.git.lazygit").config(),
    dependencies = { "nvim-lua/plenary.nvim" },
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

  ------------------------------------------------------------------------------
  -- Заметки и работа с Markdown
  --
  -- @directory [ plugins/setup/notes/* ]
  --
  -- @plugins
  -- `epwalsh/obsidian.nvim`: Работа с заметками Obsidian.
  -- `OXY2DEV/markview.nvim`: Markdown предпросмотр.
  ------------------------------------------------------------------------------

  { -- NOTES
    "epwalsh/obsidian.nvim",
    keys = require("plugins.setup.notes.obsidian").keys,
    config = require("plugins.setup.notes.obsidian").config,
  },

  { -- MARKDOWN PREVIEW in neovim
    "OXY2DEV/markview.nvim",
    ft = "markdown",
    -- setup.notes = require("plugins.setup.notes.markview").config,
  },

  ------------------------------------------------------------------------------
  -- AI и интеллектуальные инструменты
  --
  -- @directory [ plugins/setup/ai/* ]
  --
  -- @plugins
  -- `Exafunction/codeium.vim`: AI автозаполнение.
  ------------------------------------------------------------------------------

  { -- AI
    "Exafunction/codeium.vim",
    event = "BufEnter",
    config = require("plugins.setup.ai.codeium").config,
    -- FIX(issue): https://github.com/Exafunction/codeium.vim/issues/376#issuecomment-2159643405
    -- FIX: the latest update breaks the plugin. Need revert to v1.8.37 289eb72
    -- version = "1.8.37",
    -- commit = "289eb72",
  },

  ------------------------------------------------------------------------------
  -- Дебаггинг
  --
  -- @directory [ plugins/setup/debug/* ]
  --
  -- @plugins
  -- `mfussenegger/nvim-dap`: Поддержка DAP.
  -- - `rcarriga/nvim-dap-ui`: UI для дебаггинга.
  ------------------------------------------------------------------------------

  { -- DEBUG
    "mfussenegger/nvim-dap",
    config = require("plugins.setup.debug.nvim-dap").config,
    dependencies = { -- DEBUG UI
      "rcarriga/nvim-dap-ui",
      dependencies = { "nvim-neotest/nvim-nio" },
      config = require("plugins.setup.debug.nvim-dap-ui").config,
    },
  },

  ------------------------------------------------------------------------------
  -- Базы данных
  --
  -- @directory [ plugins/setup/database/* ]
  --
  -- @plugins
  -- `tpope/vim-dadbod`: Работа с базами данных.
  -- - `kristijanhusak/vim-dadbod-ui`: UI для работы с базами данных.
  -- - `kristijanhusak/vim-dadbod-completion`: Автозаполнение.
  ------------------------------------------------------------------------------

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
        init = require("plugins.setup.database.dadbod").UI.init,
      },
      { -- DATABASE AUTOCOMPLETION
        "kristijanhusak/vim-dadbod-completion",
        ft = { "sql", "mysql", "plsql" },
      },
    },
  },

  ------------------------------------------------------------------------------
  -- Оптимизация навыков
  --
  -- @directory [ plugins/setup/skill/* ]
  --
  -- @plugins
  -- `m4xshen/hardtime.nvim`: Плагины для улучшения навыков.
  -- `kawre/leetcode.nvim`: Плагин для решения задач из Leetcode.
  ------------------------------------------------------------------------------

  { -- BEST PRACTICE
    "m4xshen/hardtime.nvim",
    event = "VeryLazy",
    opts = require("plugins.setup.skill.hardtime").opts,
  },

  { -- LEETCODE
    "kawre/leetcode.nvim",
    lazy = "leetcode.nvim" ~= vim.fn.argv()[1],
    -- opts = { arg = "leetcode.nvim" },
    opts = require("plugins.setup.skill.leetcode").opts,
  },

  ------------------------------------------------------------------------------
  -- Утилиты
  --
  -- @directory [ plugins/setup/utils/* ]
  --
  -- @plugins
  -- `nvchad/nvim-showkeys`: Показывает нажатые комбинации клавиш.
  -- `mistricky/codesnap.nvim`: Создание скриншотов кода.
  ------------------------------------------------------------------------------

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

  { -- SCREENSHOTS
    "mistricky/codesnap.nvim",
    build = "make",
    cmd = { "CodeSnap", "CodeSnapSave", "CodeSnapHighlight", "CodeSnapSaveHighlight" },
    -- keys = require("plugins.setup.utils.codesnap").keys,
    opts = require("plugins.setup.utils.codesnap").opts,
  },

  ------------------------------------------------------------------------------
  -- ARCHIVE PLUGINS
  --
  -- @directory [ plugins/setup/* ]
  ------------------------------------------------------------------------------

  -- { -- SEARCH & REPLACE
  --   "nvim-pack/nvim-spectre",
  --   cmd = { "Spectre" },
  -- },

  -- { -- MARKDOWN PREVIEW
  --   "iamcco/markdown-preview.nvim",
  --   cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
  --   ft = { "markdown" },
  --   build = require("plugins.setup.markdown-preview").build,
  --   init = require("plugins.setup.markdown-preview").init,
  -- },

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

  -- { -- WINBAR LSP CONTEXT: lua > plugins > init.lua > []return
  --   "utilyre/barbecue.nvim",
  --   event = "BufReadPost",
  --   config = require("plugins.setup.barbecue").config,
  --   dependencies = { "SmiteshP/nvim-navic" },
  -- },

  -- { -- HTTP CLIENT
  --   "rest-nvim/rest.nvim",
  --   ft = { "http" },
  --   config = require("plugins.setup.rest-nvim-new").config,
  --   -- dependencies = {},
  --   -- build = "",
  -- },

  -- { -- HTTP CLIENT `kulala`
  --   "mistweaverco/kulala.nvim",
  --   ft = { "http" },
  --   init = require("plugins.setup.rest-kulala").init,
  --   config = require("plugins.setup.rest-kulala").config,
  -- },

  -- { -- HTTP CLIENT `atac`
  --   "NachoNievaG/atac.nvim",
  --   cmd = { "Atac" },
  --   dependencies = { "akinsho/toggleterm.nvim" },
  --   config = require("plugins.setup.atac").config,
  -- },

  -- { -- ZEN MODE
  --   "folke/zen-mode.nvim",
  --   cmd = { "ZenMode" },
  --   opts = require("plugins.setup.zen-mode").opts,
  --   dependencies = { -- DIMMING INACTIVE CODE
  --     "folke/twilight.nvim",
  --     opts = require("plugins.setup.zen-mode").twilight_opts,
  --   },
  -- },

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

  -- { -- CODE ANNOTATION
  --   "danymat/neogen",
  --   version = "*", -- only `stable` version plugin
  --   keys = require("plugins.setup.neogen").keys,
  --   config = require("plugins.setup.neogen").config,
  -- },

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

  -- {
  --   "yetone/avante.nvim",
  --   event = "VeryLazy",
  --   -- lazy = false,
  --   version = false, -- set this if you want to always pull the latest change
  --   opts = {
  --     mappings = {
  --       --- @class AvanteConflictMappings
  --       submit = { insert = "<leader>s" },
  --     },
  --   },
  --   build = "make", -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows (if you want to build from source then do `make BUILD_FROM_SOURCE=true`)
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "stevearc/dressing.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --   },
  -- },

  -- { -- POMODORO TIMER
  --   "nvzone/timerly",
  --   cmd = "TimerlyToggle",
  -- },
}
