require "colors"
require "plugins.setup._custom.load_env" -- for `avante.nvim` AI plugin
require "plugins.setup._custom.fzf"

return {
  --┌───────────┬─────────────────────────────────────────────────────────────┐
  --├ @catecory   LSP и Форматирование
  --│
  --├ @directory  ┌ configs/ ─────┐┌ plugins/setup/ ────┐
  --│             │ conform      ││ lsp               │
  --│             │ lspconfig    │└────────────────────┘
  --│             └───────────────┘
  --│
  --├ @plugins    ON  `stevearc/conform.nvim`: Форматирование кода.
  --│             ON  `neovim/nvim-lspconfig`: Конфигурация LSP.
  --│             OFF     └─ `saghen/blink.cmp`: Плагин завершения на RUST с поддержкой LSP и внешних источников. Производительнее чем `hrsh7th/nvim-cmp`. Использую для собственной конфигурации в будующем.
  --│             ON  `williamboman/mason.nvim`: Установщик LSP и других инструментов.
  --│             OFF `smjonas/inc-rename.nvim`: Переименование.
  --└───────────┴─────────────────────────────────────────────────────────────┘

  { -- FORMATTERS
    "stevearc/conform.nvim",
    -- event = "BufWritePre", -- format on save
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
    dependencies = { -- ALTERNATIVE AUTOCOMPLETION
      --   "saghen/blink.cmp",
      --   lazy = false,
      --   version = "v0.*",
      --   opts = require("plugins.setup.lsp.blink-cmp").opts,
      --   dependencies = {
      --     "rafamadriz/friendly-snippets",
      --     { "hrsh7th/nvim-cmp", enabled = false }, -- disable default `nvim-cmp`
      --   },

      -- { import = "nvchad.blink.lazyspec" },
      -- { -- WARN: TEST `Saghen/blink.cmp` plugin to NvChad
      --   -- see: https://github.com/NvChad/NvChad/discussions/3244
      --   "hrsh7th/nvim-cmp",
      --   opts = function()
      --     -- return require "configs.cmp"
      --     local config = require "nvchad.configs.cmp"
      --     local cmp = require "cmp"
      --
      --     config.mapping["<CR>"] = cmp.mapping.confirm {
      --       behavior = cmp.ConfirmBehavior.Insert,
      --       select = false,
      --     }
      --
      --     config.completion = {
      --       completeopt = "menu,menuone,noselect,popup",
      --     }
      --
      --     config.preselect = cmp.PreselectMode.None
      --
      --     return config
      --   end,
      -- },
    },
  },

  { -- LSP INSTALLER
    "williamboman/mason.nvim",
    opts = require("plugins.setup.lsp.mason").opts,
  },

  -- { -- RENAME
  --   "smjonas/inc-rename.nvim",
  --   lazy = false,
  --   config = function()
  --     require("inc_rename").setup()
  --   end,
  -- },

  --┌───────────┬─────────────────────────────────────────────────────────────┐
  --├ @category   Работа с деревом и синтаксисом
  --│
  --├ @directory  ┌ plugins/setup/ ────┐
  --│             │ treesitter        │
  --│             └────────────────────┘
  --│
  --├ @plugins    ON  `nvim-treesitter/nvim-treesitter`: Дерево синтаксиса и подсветка.
  --│             ON      ├─ `folke/ts-comments.nvim`: Контекстные комментарии.
  --│             ON      ├─ `windwp/nvim-ts-autotag`: Автозакрытие HTML-тегов.
  --│             OFF     ├─ `RRethy/vim-illuminate`: Подсветка переменных под курсором (treesitter).
  --│             ON      ├─ `nvim-treesitter/nvim-treesitter-textobjects`: Работа с текстовыми объектами.
  --│             ON      ├─ `echasnovski/mini.ai`: Работа с текстовыми объектами.
  --│             ON      ├─ `echasnovski/mini.cursorword`: Подсветка переменных под курсором (regularexp).
  --│             ON      └─ `Treewalker.nvim`: Быстрое перемещение по синтаксическому дереву.
  --│             ON  `gbprod/yanky.nvim`: Улучшает работу с регистрами, изменяя поведение удаления/копирования/вставки.
  --└───────────┴─────────────────────────────────────────────────────────────┘

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
      { -- TS TEXT-OBJECTS MANIPULATE
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = "BufReadPost",
        config = require("plugins.setup.treesitter.nvim-ts-textobjects").config,
      },
      -- { -- COLLECTION LUA MODULES
      --   "echasnovski/mini.nvim",
      --   version = false,
      --   config = require("plugins.setup.treesitter.mini-nvim").config,
      -- },
      { -- REGULAR MANIPULATE
        "echasnovski/mini.ai",
        init = function()
          require("mini.ai").setup {}
        end,
      },
      { -- HIGHLIGHT VARS UNDER CURSOR
        "echasnovski/mini.cursorword",
        init = function()
          require("mini.cursorword").setup {}
        end,
      },
      { -- TREE MOVER
        "aaronik/treewalker.nvim",
        opts = { highlight = true },
      },
    },
  },

  { -- BETTER REGISTERS
    "gbprod/yanky.nvim",
    event = "VeryLazy",
    opts = require("plugins.setup.treesitter.yanky").opts,
    -- init = function()
    --   require("telescope").load_extension "yank_history"
    -- end,
  },

  {
    "b0o/schemastore.nvim",
    lazy = false,
  },
  -- {
  --   "ramilito/kubectl.nvim",
  --   -- use a release tag to download pre-built binaries
  --   version = "2.*",
  --   -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  --   -- build = 'cargo build --release',
  --   dependencies = "saghen/blink.download",
  --   keys = {
  --     { "<leader>k", "<cmd>lua require('kubectl').toggle()<cr>", mode = "n", desc = "toggle kube (Kubectl)" },
  --   },
  --   config = function()
  --     require("kubectl").setup()
  --   end,
  -- },

  --┌───────────┬─────────────────────────────────────────────────────────────┐
  --├ @category   Файловая система
  --│
  --├ @directory  ┌ plugins/setup/ ────┐
  --│             │ filesystem        │
  --│             └────────────────────┘
  --│
  --├ @plugins    ON  `nvim-tree/nvim-tree.lua`: Файловый менеджер.
  --│             ON  `DreamMaoMao/yazi.nvim`: Альтернативный файловый менеджер.
  --│             ON  `stevearc/oil.nvim`: Работа с буферами.
  --└───────────┴─────────────────────────────────────────────────────────────┘

  -- @default
  { -- FILE EXPLORER
    "nvim-tree/nvim-tree.lua",
    opts = require("plugins.setup.filesystem.nvim-tree").opts,
    init = require("plugins.setup.filesystem.nvim-tree").init,
  },

  { -- FILE MANAGER
    "DreamMaoMao/yazi.nvim",
    keys = { { "<leader>gy", "<cmd>Yazi<CR>", desc = "Toggle Yazi" } },
  },

  { -- BUFFER FILE EXPLORER
    "stevearc/oil.nvim",
    opts = require("plugins.setup.filesystem.oil").opts,
  },

  --┌───────────┬─────────────────────────────────────────────────────────────┐
  --│ @category   Навигация
  --│
  --│ @directory  ┌ plugins/setup/ ────┐
  --│             │ navigation        │
  --│             └────────────────────┘
  --│
  --│ @plugins    ON  `folke/flash.nvim`: Улучшенная навигация.
  --│             ON  `kylechui/nvim-surround`: Улучшенное редактирование окружений.
  --│             ON  `mg979/vim-visual-multi`: Улучшенная многокурсорная навигация.
  --│             OFF `nvim-telescope/telescope-fzf-native.nvim`: Улучшенный поиск в telescope с fzf.
  --│             ON  `ibhagwan/fzf-lua`: Поиск посредством fzf установленного в системе (значительно быстрее).
  --└───────────┴─────────────────────────────────────────────────────────────┘

  { -- NAVIGATION
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = require("plugins.setup.navigation.flash").opts,
    keys = require("plugins.setup.navigation.flash").keys,
  },

  { -- PRO REDEFINITION
    "kylechui/nvim-surround",
    version = "^3.0.0",
    event = "VeryLazy",
    config = require("plugins.setup.navigation.nvim-surround").config,
  },

  { -- MULTI-CURSOR
    "mg979/vim-visual-multi",
    branch = "master",
    keys = require("plugins.setup.navigation.vim-visual-multi").keys,
    init = require("plugins.setup.navigation.vim-visual-multi").init,
  },

  -- { -- FZF
  --   -- INFO: `:Telescope load_extension fzf` OR go to `$HOME/.local/share/nvim/lazy/telescope-fzf-native.nvim` and run `make`
  --   "nvim-telescope/telescope-fzf-native.nvim",
  --   event = "VeryLazy",
  --   -- build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
  --   config = function()
  --     require("telescope").load_extension "fzf"
  --   end,
  -- },

  --┌───────────┬─────────────────────────────────────────────────────────────┐
  --├ @category   Интерфейс
  --│
  --├ @directory  ┌ plugins/setup/ ────┐
  --│             │ interface         │
  --│             └────────────────────┘
  --│
  --├ @plugins    ON  `folke/snacks.nvim`: Улучшенный UI.
  --├             ON  `folke/noice.nvim`: Улучшенный UI messages|cmdline|popupmenu.
  --│             ON      ├─ `MunifTanjim/nui.nvim`: используется для правильного рендеринга и многократного просмотра.
  --│             OFF     └─ `rcarriga/nvim-notify`: Улучшенный просмотр уведомлений.
  --│             OFF `rmagatti/goto-preview`: Улучшеное плавающее окно для быстрого просмотра.
  --│             ON  `folke/trouble.nvim`: Улучшенная работа с quickfix.
  --│             ON  `folke/todo-comments.nvim`: TODO-комментарии.
  --│             ON  `kevinhwang91/nvim-ufo`: Улучшенная работа с фолдерами.
  --│             ON      └─ `kevinhwang91/promise-async`: Promise/Async для работы в lua.
  --│             ON  `folke/persistence.nvim`: Сохранение/Восстановление состояния.
  --│             OFF `utilyre/barbecue.nvim`: Строка текущего положения курсора в синтаксическом древе.
  --│             OFF `folke/zen-mode.nvim`: Полноэкранный режим с отключение всего UI.
  --│             OFF     └─ `folke/twilight.nvim`: Затемняет неактивные части редактируемого кода.
  --│             ON  `sphamba/smear-cursor.nvim`: Добавляет анимацию для курсора в терминале.
  --│             OFF     └─ `danilamihailov/beacon.nvim`: Выделяет мерцанием курсор, когда он движется, меняет окна и многое другое.
  --│             OFF `Bekaboo/dropbar.nvim`: Полоска текущего положения курсора в контексе с кликабельным UI.
  --│             OFF `y3owk1n/undo-glow.nvim`: Подсветка с анимацией undo/redo.
  --│             OFF `atiladefreitas/dooing`: TODO список.
  --│             ON  `hat0uma/csvview.nvim`: Приятное оформление CSV таблиц.
  --│             OFF `nvzone/floaterm`: Плавающий терминал.
  --└───────────┴─────────────────────────────────────────────────────────────┘

  { -- UI
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = require("plugins.setup.interface.snacks").opts,
  },

  { -- UI MESSAGEGS
    "folke/noice.nvim",
    event = "VeryLazy",
    config = require("plugins.setup.interface.noice").config,
    dependencies = {
      "MunifTanjim/nui.nvim",
      -- "rcarriga/nvim-notify",
    },
  },

  -- { -- PREVIEW FLOAT
  --   "rmagatti/goto-preview",
  --   event = "BufEnter",
  --   config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
  -- },

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

  -- { -- FOLDER experiment
  --   "nicolas-martin/region-folding.nvim",
  --   event = { "BufReadPost", "BufNewFile" },
  --   opts = {},
  --   init = function()
  --     -- Enable treesitter folding (required for function folding)
  --     vim.opt.foldmethod = "expr"
  --     vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
  --     vim.opt.foldenable = true
  --     vim.opt.foldlevel = 99
  --     vim.opt.foldlevelstart = 99
  --   end,
  -- },

  { -- SESSIONS
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = require("plugins.setup.interface.presistence").opts,
  },

  -- { -- WINBAR
  --   "utilyre/barbecue.nvim",
  --   event = "BufReadPost",
  --   config = require("plugins.setup.interface.barbecue").config,
  --   dependencies = { "SmiteshP/nvim-navic" },
  -- },

  -- { -- ZEN MODE
  --   "folke/zen-mode.nvim",
  --   cmd = { "ZenMode" },
  --   opts = require("plugins.setup.interface.zen-mode").opts,
  --   dependencies = { -- DIMMING INACTIVE CODE
  --     "folke/twilight.nvim",
  --     opts = require("plugins.setup.interface.zen-mode").twilight_opts,
  --   },
  -- },

  { -- SMOOTH CURSOR
    "sphamba/smear-cursor.nvim",
    -- enabled = false,
    event = "VeryLazy",
    opts = require("plugins.setup.interface.smear-cursor").opts,
    init = function()
      require("smear_cursor").setup {
        cursor_color = COLORS.primary,
        normal_bg = COLORS.primary_ghost,
      }
    end,

    -- dependencies = { -- CURSOR FLICK
    --   "danilamihailov/beacon.nvim",
    --   opts = {
    --     highlight = { bg = COLORS.primary_ghost },
    --   }
    -- },
  },

  { -- CONTEXT DROPBAR
    "Bekaboo/dropbar.nvim",
    event = "BufReadPost",
  },

  -- { -- HIGHLIGHT UNDO
  --   "y3owk1n/undo-glow.nvim",
  --   event = { "VeryLazy" },
  --   opts = require("plugins.setup.interface.undo-glow").opts,
  --   keys = require("plugins.setup.interface.undo-glow").keys,
  --   init = require("plugins.setup.interface.undo-glow").init,
  -- },

  -- { -- TODO MANAGER
  --   "atiladefreitas/dooing",
  --   cmd = { "Dooing" },
  --   config = require("plugins.setup.interface.dooing").config,
  -- },

  { -- CSV VIEW
    "hat0uma/csvview.nvim",
    ft = "csv",
    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
    opts = require("plugins.setup.interface.csvview").opts,
    config = require("plugins.setup.interface.csvview").config,
  },

  -- { -- FLOATING TERMINAL
  --   "nvzone/floaterm",
  --   dependencies = "nvzone/volt",
  --   opts = {},
  --   cmd = "FloatermToggle",
  --   mappings = {
  --     term = function(buf)
  --       vim.keymap.set({ "n", "t" }, "<C-p>", function()
  --         require("floaterm.api").cycle_term_bufs "prev"
  --       end, { buffer = buf })
  --     end,
  --   },
  -- },

  --┌───────────┬─────────────────────────────────────────────────────────────┐
  --├ @category   Поиск и замена
  --│
  --├ @directory  ┌ plugins/setup/ ────┐
  --│             │ search            │
  --│             └────────────────────┘
  --│
  --├ @plugins    ON  `MagicDuck/grug-far.nvim`: Поиск и замена.
  --│             OFF `nvim-pack/nvim-spectre`: Поиск и замена (old).
  --└───────────┴─────────────────────────────────────────────────────────────┘

  { -- SEARCH & REPLACE
    "MagicDuck/grug-far.nvim",
    config = require("plugins.setup.search.grug-far").config,
  },

  -- { -- SEARCH & REPLACE
  --   "nvim-pack/nvim-spectre",
  --   cmd = { "Spectre" },
  -- },

  --┌───────────┬─────────────────────────────────────────────────────────────┐
  --├ @category   Git и работа с версиями
  --│
  --├ @directory  ┌ plugins/setup/ ────┐
  --│             │ git               │
  --│             └────────────────────┘
  --│
  --├ @plugins    OFF `kdheepak/lazygit.nvim`: Интеграция с LazyGit. REASON: use lazygit in `folke/snacks.nvim`
  --│             ON  `sindrets/diffview.nvim`: Просмотр изменений.
  --└───────────┴─────────────────────────────────────────────────────────────┘

  -- { -- GIT
  --   "kdheepak/lazygit.nvim",
  --   cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile" },
  --   config = require("plugins.setup.git.lazygit").config(),
  -- },

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

  --┌───────────┬─────────────────────────────────────────────────────────────┐
  --├ @category   Заметки и работа с Markdown
  --│
  --├ @directory  ┌ plugins/setup/ ────┐
  --│             │ notes             │
  --│             └────────────────────┘
  --│
  --├ @plugins    ON  `epwalsh/obsidian.nvim`: Работа с заметками Obsidian.
  --│             ON  `OXY2DEV/markview.nvim`: Улучшенное отображение Markdown файлов.
  --│             ON  `iamcco/markdown-preview.nvim`: Markdown предпросмотр в браузере.
  --│             OFF `3rd/image.nvim`: Просмотр изображений в терминале.
  --│             OFF `timantipov/md-table-tidy.nvim`: Простое редактирование таблиц в Markdown. Конфликтит с `OXY2DEV/markview.nvim`.
  --└───────────┴─────────────────────────────────────────────────────────────┘

  { -- NOTES
    "epwalsh/obsidian.nvim",
    keys = require("plugins.setup.notes.obsidian").keys,
    config = require("plugins.setup.notes.obsidian").config,
  },

  { -- MARKDOWN PREVIEW (neovim)
    "OXY2DEV/markview.nvim",
    ft = "markdown",
    -- setup.notes = require("plugins.setup.notes.markview").config,
  },

  { -- MARKDOWN PREVIEW (browser)
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = "markdown",
    build = "cd app && npm install --frozen-lockfile",
    init = require("plugins.setup.notes.markdown-preview").init,
  },

  -- { -- IMAGE PREVIEW (neovim)
  --   "3rd/image.nvim",
  --   lazy = "BufReadPost",
  --   ft = "markdown",
  --   config = require("plugins.setup.notes.image-nvim").config,
  -- },

  -- { -- MD TABLES
  --   "timantipov/md-table-tidy.nvim",
  --   ft = "markdown",
  --   cmd = { "TableTidy" },
  --   opts = {
  --     padding = 1, -- number of spaces for cell padding
  --     key = "<leader>tt", -- key for command :TableTidy<CR>
  --   },
  -- },

  --┌───────────┬─────────────────────────────────────────────────────────────┐
  --├ @category   AI и интеллектуальные инструменты
  --│
  --├ @directory  ┌ plugins/setup/ ────┐
  --│             │ ai                │
  --│             └────────────────────┘
  --│
  --├ @plugins    ON  `Exafunction/codeium.vim`: AI автозаполнение.
  --├             ON  `yetone/avante.nvim`: Отличный провайдер AI моделей.
  --│             OFF     ├─ `stevearc/dressing.nvim`: Core UI inputs.
  --│             ON      ├─ `nvim-lua/plenary.nvim`: Переиспользование написаных функций для lua.
  --│             ON      └─ `MunifTanjim/nui.nvim: используется для правильного рендеринга и многократного просмотра.
  --├             OFF `augmentcode/augment.vim`: обеспечивает завершение встроенного кода и многошобразные разговоры в чате, адаптированные к кодовой базе
  --├             OFF `olimorris/codecompanion.nvim`: попробую этот новый плагин
  --└───────────┴─────────────────────────────────────────────────────────────┘

  { -- SMALL AI COMPLETION
    "Exafunction/codeium.vim",
    event = "BufEnter",
    config = require("plugins.setup.ai.codeium").config,
  },

  -- { -- NEOVIM AI -> CURSOR
  --   "yetone/avante.nvim",
  --   -- event = "BufReadPost",
  --   event = "VeryLazy",
  --   lazy = false,
  --   opts = require("plugins.setup.ai.avante").opts,
  --   build = "make", -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --   dependencies = {
  --     -- "stevearc/dressing.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --   },
  -- },

  -- {
  --   -- WARN: free plan include only 50 messeges per month. Out of tokens on free plan. Next plan: `Developer plan` include 600 messages and cost $50/month.
  --   "augmentcode/augment.vim",
  --   event = "VeryLazy",
  --   -- cmd = { "Augment" },
  --   init = function()
  --     -- augment `workspace` folders
  --     vim.g.augment_workspace_folders = { "~/work/github.com/zhenya-paitash/app-organify" }
  --     vim.g.augment_disable_tab_mapping = true
  --     -- vim.g.augment_disable_completions = true
  --     -- Use Ctrl-Y to accept a suggestion
  --     vim.keymap.set("i", "<C-f>", "<cmd>call augment#Accept()<CR>", { silent = true })
  --   end,
  -- },

  -- { -- Code Companion
  --   "olimorris/codecompanion.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  --   config = require("plugins.setup.ai.codecompanion").config,
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  -- },

  --┌───────────┬─────────────────────────────────────────────────────────────┐
  --├ @category   Дебаггинг
  --│
  --├ @directory  ┌ plugins/setup/ ────┐
  --│             │ debug             │
  --│             └────────────────────┘
  --│
  --├ @plugins    ON  `mfussenegger/nvim-dap`: Поддержка DAP.
  --│             OFF     └─ `theHamsta/nvim-dap-virtual-text`: подсказки сразу на линии остановки.
  --│             OFF     └─ `rcarriga/nvim-dap-ui`: UI для дебаггинга.
  --└───────────┴─────────────────────────────────────────────────────────────┘

  { -- DEBUG
    "mfussenegger/nvim-dap",
    config = require("plugins.setup.debug.nvim-dap").config,
    dependencies = {
      -- { "theHamsta/nvim-dap-virtual-text", config = true },

      { -- DEBUG UI
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        config = require("plugins.setup.debug.nvim-dap-ui").config,
      },

      -- { -- NEW DEBUG UI
      --   "miroshQa/debugmaster.nvim",
      --   cmd = "DebugMaster",
      --   config = require("plugins.setup.debug.debugmaster").config,
      -- },
    },
  },

  --┌───────────┬─────────────────────────────────────────────────────────────┐
  --├ @category   Базы данных
  --│
  --├ @directory  ┌ plugins/setup/ ────┐
  --│             │ database          │
  --│             └────────────────────┘
  --│
  --├ @plugins    ON  `tpope/vim-dadbod`: Работа с базами данных.
  --│             ON      ├─ `kristijanhusak/vim-dadbod-ui`: UI для работы с базами данных.
  --│             ON      └─ `kristijanhusak/vim-dadbod-completion`: Автозаполнение.
  --└───────────┴─────────────────────────────────────────────────────────────┘

  { -- DATABASE UI
    "kristijanhusak/vim-dadbod-ui",
    cmd = {
      "DB",
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = require("plugins.setup.database.dadbod").UI.init,
    dependencies = {
      { -- DATABASE
        "tpope/vim-dadbod",
        lazy = true,
      },
      { -- DATABASE AUTOCOMPLETION
        "kristijanhusak/vim-dadbod-completion",
        ft = { "sql", "mysql", "plsql" },
        lazy = true,
      },
    },
  },

  --┌───────────┬─────────────────────────────────────────────────────────────┐
  --├ @category   Оптимизация навыков
  --│
  --├ @directory  ┌ plugins/setup/ ────┐
  --│             │ skill             │
  --│             └────────────────────┘
  --│
  --├ @plugins    ON  `m4xshen/hardtime.nvim`: Плагины для улучшения навыков.
  --│             ON  `kawre/leetcode.nvim`: Плагин для решения задач из Leetcode.
  --│             ON  `nvzone/typr`: Практика навыков печати внутри neovim.
  --└───────────┴─────────────────────────────────────────────────────────────┘

  -- { -- BEST PRACTICE
  --   "m4xshen/hardtime.nvim",
  --   event = "VeryLazy",
  --   opts = require("plugins.setup.skill.hardtime").opts,
  -- },

  { -- LEETCODE
    "kawre/leetcode.nvim",
    lazy = "leetcode.nvim" ~= vim.fn.argv()[1],
    opts = require("plugins.setup.skill.leetcode").opts,
  },

  -- { -- TYPING PRACTICE
  --   "nvzone/typr",
  --   dependencies = "nvzone/volt",
  --   opts = {},
  --   cmd = { "Typr", "TyprStats" },
  -- },

  --┌───────────┬─────────────────────────────────────────────────────────────┐
  --├ @category   HTTP REST клиенты
  --│
  --├ @directory  ┌ plugins/setup/ ────┐
  --│             │ http              │
  --│             └────────────────────┘
  --│
  --├ @plugins    OFF `rest-nvim/rest.nvim`: HTTP клиент.
  --│             OFF `mistweaverco/kulala.nvim`: Более новый REST HTTP клиент.
  --│             OFF `NachoNievaG/atac.nvim`: Плагин для работы с `ATAC` в neovim.
  --└───────────┴─────────────────────────────────────────────────────────────┘

  -- { -- HTTP CLIENT
  --   "rest-nvim/rest.nvim",
  --   ft = { "http" },
  --   config = require("plugins.setup.http.rest-nvim-new").config,
  --   -- dependencies = {},
  --   -- build = "",
  -- },

  -- { -- HTTP CLIENT `kulala`
  --   "mistweaverco/kulala.nvim",
  --   ft = { "http" },
  --   init = require("plugins.setup.http.rest-kulala").init,
  --   config = require("plugins.setup.http.rest-kulala").config,
  -- },

  -- { -- HTTP CLIENT `atac`
  --   "NachoNievaG/atac.nvim",
  --   cmd = { "Atac" },
  --   dependencies = { "akinsho/toggleterm.nvim" },
  --   config = require("plugins.setup.http.atac").config,
  -- },

  --┌───────────┬─────────────────────────────────────────────────────────────┐
  --├ @category   Утилиты
  --│
  --├ @directory  ┌ plugins/setup/ ────┐
  --│             │ utils             │
  --│             └────────────────────┘
  --│
  --├ @plugins    ON  `nvchad/nvim-showkeys`: Показывает нажатые комбинации клавиш.
  --│             ON  `mistricky/codesnap.nvim`: Создание скриншотов кода.
  --└───────────┴─────────────────────────────────────────────────────────────┘

  { -- SHOW KEYS
    "nvchad/showkeys",
    cmd = "ShowkeysToggle",
    opts = {
      -- timeout = 1,
      maxkeys = 3,
      position = "bottom-right",
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

  --┌───────────┬─────────────────────────────────────────────────────────────┐
  --├ @category   JUST FOR FUN
  --│
  --├ @plugins    ON  `seandewar/actually-doom.nvim`: DOOM game in neovim.
  --└───────────┴─────────────────────────────────────────────────────────────┘

  -- { -- DOOM
  --   "seandewar/actually-doom.nvim",
  --   cmd = "Doom",
  -- },

  --┌───────────┬─────────────────────────────────────────────────────────────┐
  --├ @category   ARCHIVE PLUGINS
  --│
  --├ @directory  ┌ plugins/setup/ ────┐
  --│             │ *                 │
  --│             └────────────────────┘
  --└───────────┴─────────────────────────────────────────────────────────────┘

  -- { -- TESTS
  --   "nvim-neotest/neotest",
  --   dependencies = {
  --     "nvim-neotest/nvim-nio",
  --     "nvim-lua/plenary.nvim",
  --     -- "antoinemadec/FixCursorHold.nvim",  -- WARN:  This plugin is not needed after neovim/neovim#20198
  --   },
  -- },
}
