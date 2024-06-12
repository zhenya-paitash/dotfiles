return {
  opts = {
    on_attach = function(bufnr)
      local api = require "nvim-tree.api"
      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end
      -- default mappings
      api.config.mappings.default_on_attach(bufnr)
      -- custom mappings
      vim.keymap.set("n", "l", api.node.open.edit, opts "Custom Open")
      vim.keymap.set("n", "h", api.node.navigate.parent_close, opts "Custom Close Directory")
      vim.keymap.set("n", "?", api.tree.toggle_help, opts "Custom Help")
    end,

    git = {
      enable = true,
    },

    modified = {
      enable = true,
      show_on_dirs = false,
    },

    view = {
      -- adaptive_size = true,
      -- side = "left",
      -- width = 30,
      preserve_window_proportions = true,

      debounce_delay = 15,
      centralize_selection = false,
      cursorline = true,

      float = {
        enable = true,
        quit_on_focus_loss = true,
        open_win_config = function()
          local screen_w = vim.opt.columns:get()
          local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
          local window_w = screen_w * 0.5
          local window_h = screen_h * 0.5
          local window_w_int = math.floor(window_w)
          local window_h_int = math.floor(window_h)
          local center_x = (screen_w - window_w) / 2
          local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
          return {
            relative = "editor",
            border = "rounded",
            row = center_y,
            col = center_x,
            width = window_w_int,
            height = window_h_int,
          }
        end,
      },
    },

    actions = {
      open_file = {
        quit_on_open = true,
      },
      remove_file = {
        close_window = false,
      },
    },

    renderer = {
      highlight_git = true,

      icons = {
        show = {
          modified = true,
          git = true,
        },

        glyphs = {
          default = "󰈚 ",
          symlink = " ",
          modified = "!",
          folder = {
            default = " ",
            open = " ",
            empty = " ",
            empty_open = " ",
          },
        },
      },

      -- indent_width = 1,
      -- highlight_opened_files = "none",
      -- indent_markers = {
      --   enable = true,
      --   inline_arrows = false,
      --   icons = {
      --     corner = "╰─",
      --     edge = "︳",
      --     item = "︳",
      --     bottom = "─",
      --     none = " ",
      --   },
      -- },
    },
  },
}
