---@type MappingsTable
local M = {}

M.general = {
  n = {
    -- [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>a"] = { "ggVGo", opts = { noremap = true, silent = true }, "Select all" },

    -- WARN: comment lua/mappings ["<leader>s"]
    ["<leader>w"] = { "<cmd> w <CR>", "Save file" },
  },

  v = {
    [">"] = { ">gv", "indent" },
  },

  i = {
    -- ["<C-j>"] = { "<ESC> <cmd> m .+1 <CR> == gi" },
    -- ["<C-k>"] = { "<ESC> <cmd> m .-2 <CR> == gi" },
  },

  x = {
    -- switch lines mapping
    ["J"] = { ":m '>+1 <CR> gv-gv", opts = { noremap = true, silent = true } },
    ["K"] = { ":m '<-2 <CR> gv-gv", opts = { noremap = true, silent = true } },
  },
}

-- more keybinds!
M.telescope = {
  plugin = true,

  n = {
    ["<leader><leader>"] = { "<cmd> Telescope find_files <CR>", "Find files" },
    ["<leader>gb"] = { "<cmd> Telescope git_branches <CR>", "Git branch" },
    -- ["<leader>gr"] = { function() require("telescope.builtin").lsp_references() end, "Find references" },
    ["gr"] = { function() require("telescope.builtin").lsp_references() end, "Find references" },
    -- ["<leader>gd"] = { function() require("telescope.builtin").lsp_definitions() end, "Find definitions" },
    ["<leader>ft"] = { "<cmd> Telescope terms <CR>", "Find terms" },
    ["<leader>*"] = {
      function()
        require("telescope.builtin").grep_string()
      end,
      "Grep string",
    },
  },
  v = {
    ["<leader>*"] = {
      function()
        require("telescope.builtin").grep_string()
      end,
      "Grep string",
    },
  },
}

M.tabufline = {
  plugin = true,

  n = {
    -- close other buffers
    ["<leader>X"] = {
      function()
        -- require("nvchad.tabufline").closeOtherBufs()
        require("nvchad.tabufline").closeAllBufs()
        vim.cmd "NvimTreeFocus"
      end,
      "Close other buffers",
    },
  },
}

M.trouble = {
  -- TODO: find where i can add my custom plugins to M prototype
  -- plugin = true,

  n = {
    ["<leader>t"] = {
      function()
        require("trouble").open()
      end,
      "Trouble open",
    },

    ["<leader>td"] = {
      function()
        require("trouble").open "document_diagnostics"
      end,
      "Trouble document_diagnostics",
    },

    ["<leader>tw"] = {
      function()
        require("trouble").open "workspace_diagnostics"
      end,
      "Trouble workspace_diagnostics",
    },

    ["<leader>tq"] = {
      function()
        require("trouble").open "quickfix"
      end,
      "Trouble quickfix",
    },

    ["<leader>tl"] = {
      function()
        require("trouble").open "loclist"
      end,
      "Trouble loclist",
    },

    ["<leader>tr"] = {
      function()
        require("trouble").open "lsp_references"
      end,
      "Trouble lsp_references",
    },

    ["<leader>t]"] = {
      function()
        require("trouble").next { skip_groups = true, jump = true }
      end,
      "Trouble next",
    },

    ["<leader>t["] = {
      function()
        require("trouble").previous { skip_groups = true, jump = true }
      end,
      "Trouble previous",
    },
  },
}

-- M.flash = {
--   -- plugin = true,
--
--   n = {
--     ["f"] = {
--       function()
--         require("flash").jump()
--       end,
--       "Flash",
--     },
--     ["F"] = {
--       function()
--         require("flash").treesitter()
--       end,
--       "Flash Treesitter",
--     },
--     ["s"] = {
--       function()
--         require("flash").jump()
--       end,
--       "Flash",
--     },
--     ["S"] = {
--       function()
--         require("flash").treesitter()
--       end,
--       "Flash Treesitter",
--     },
--   },
--   x = {
--     ["s"] = {
--       function()
--         require("flash").jump()
--       end,
--       "Flash",
--     },
--     ["S"] = {
--       function()
--         require("flash").treesitter()
--       end,
--       "Flash Treesitter",
--     },
--   },
--   o = {
--     ["s"] = {
--       function()
--         require("flash").jump()
--       end,
--       "Flash",
--     },
--     ["S"] = {
--       function()
--         require("flash").treesitter()
--       end,
--       "Flash Treesitter",
--     },
--   },
-- }

M.todocomments = {
  -- plugin = true,
  n = {
    ["<leader>to"] = { "<cmd> TodoTrouble <CR>", opts = { noremap = true, silent = true }, "Todo Trouble" },
    ["<leader>fo"] = { "<cmd> TodoTelescope <CR>", opts = { noremap = true, silent = true }, "Todo Telescope" },
  },
}

M.dap = {
  -- plugin = true,
  n = {
    -- DAP
    ["<leader>ds"] = { "<cmd> lua require('dap').continue() <CR>", "Start/Continue" },
    ["<leader>dR"] = { "<cmd> lua require('dap').restart_frame() <CR>", "Restart" },
    ["<leader>dr"] = { "<cmd> lua require('dap').repl.toggle() <CR>", "Toggle REPL" },
    ["<leader>dq"] = { "<cmd> lua require('dap').close() <CR>", "Close Session" },
    ["<leader>db"] = { "<cmd> lua require('dap').toggle_breakpoint() <CR>", "Toggle breakpoint" },
    ["<leader>dB"] = { "<cmd> lua require('dap').clear_breakpoints() <CR>", "Clear Breakpoints" },
    ["<leader>di"] = { "<cmd> lua require('dap').step_into() <CR>", "Step Into" },
    ["<leader>do"] = { "<cmd> lua require('dap').step_over() <CR>", "Step Over" },
    ["<leader>dO"] = { "<cmd> lua require('dap').step_out() <CR>", "Step Out" },
    ["<leader>dQ"] = { "<cmd> lua require('dap').terminate() <CR>", "Terminate Session" },
    ["<leader>dp"] = { "<cmd> lua require('dap').pause() <CR>", "Pause" },
    ["<leader>dc"] = { "<cmd> lua require('dap').run_to_cursor() <CR>", "Run to cursor" },

    -- DAPUI
    ["<leader>du"] = {
      function()
        require("dapui").toggle()
      end,
      opts = { noremap = true, silent = true },
      "UI toggle",
    },
    ["<leader>dK"] = {
      function()
        vim.ui.input({ prompt = "Expression: " }, function(expr)
          if expr then
            require("dapui").eval(expr, { enter = true })
          end
        end)
      end,
      "Evaluate Input",
    },
    -- maps.n["<leader>du"] = { function() require("dapui").toggle() end, desc = "Toggle Debugger UI" }
    -- maps.n["<leader>dh"] = { function() require("dap.ui.widgets").hover() end, desc = "Debugger Hover" }
  },
  v = {
    ["<leader>dK"] = {
      function()
        require("dapui").eval()
      end,
      "Evaluate Input",
    },
  },
}

M.lazygit = {
  -- plugin = true,
  n = {
    ["<leader>gl"] = { "<cmd> LazyGit <CR>", "LazyGit" },
  },
}

return M
