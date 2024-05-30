return {
  -- INFO: old config
  -- opts = {
  --   position = "bottom", -- position of the list can be: bottom, top, left, right
  --   -- height = 15, -- height of the trouble list when position is top or bottom
  --   -- width = 50, -- width of the list when position is left or right
  --   icons = true, -- use devicons for filenames
  --   mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
  --   severity = nil, -- nil (ALL) or vim.diagnostic.severity.ERROR | WARN | INFO | HINT
  --   fold_open = "", -- icon used for open folds
  --   fold_closed = "", -- icon used for closed folds
  --   group = true, -- group results by file
  --   padding = false, -- add an extra new line on top of the list
  --   cycle_results = true, -- cycle item list when reaching beginning or end of list
  --   action_keys = { -- key mappings for actions in the trouble list
  --     -- map to {} to remove a mapping, for example:
  --     -- close = {},
  --     close = "q", -- close the list
  --     cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
  --     refresh = "r", -- manually refresh
  --     jump = { "<cr>", "<tab>", "<2-leftmouse>" }, -- jump to the diagnostic or open / close folds
  --     open_split = { "<c-x>" }, -- open buffer in new split
  --     open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
  --     open_tab = { "<c-t>" }, -- open buffer in new tab
  --     jump_close = { "o" }, -- jump to the diagnostic and close the list
  --     toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
  --     switch_severity = "s", -- switch "diagnostics" severity filter level to HINT / INFO / WARN / ERROR
  --     toggle_preview = "P", -- toggle auto_preview
  --     hover = "K", -- opens a small popup with the full multiline message
  --     preview = "p", -- preview the diagnostic location
  --     open_code_href = "c", -- if present, open a URI with more information about the diagnostic error
  --     close_folds = { "zM", "zm" }, -- close all folds
  --     open_folds = { "zR", "zr" }, -- open all folds
  --     toggle_fold = { "zA", "za" }, -- toggle fold of current file
  --     previous = "k", -- previous item
  --     next = "j", -- next item
  --     help = "?", -- help menu
  --   },
  --   multiline = true, -- render multi-line messages
  --   indent_lines = true, -- add an indent guide below the fold icons
  --   win_config = { border = "single" }, -- window configuration for floating windows. See |nvim_open_win()|.
  --   auto_open = false, -- automatically open the list when you have diagnostics
  --   auto_close = false, -- automatically close the list when you have no diagnostics
  --   auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
  --   auto_fold = false, -- automatically fold a file trouble list at creation
  --   auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
  --   -- include_declaration = { "lsp_references", "lsp_implementations", "lsp_definitions" }, -- for the given modes, include the declaration of the current symbol in the results
  --   signs = {
  --     -- icons / text used for a diagnostic
  --     error = "",
  --     warning = "",
  --     hint = "",
  --     information = "",
  --     other = "",
  --   },
  --   use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
  -- },

  ---@class trouble.Mode: trouble.Config,trouble.Section.spec
  ---@field desc? string
  ---@field sections? string[]
  ---
  ---@class trouble.Config
  ---@field mode? string
  ---@field config? fun(opts:trouble.Config)
  ---@field formatters? table<string,trouble.Formatter> custom formatters
  ---@field filters? table<string, trouble.FilterFn> custom filters
  ---@field sorters? table<string, trouble.SorterFn> custom sorters
  opts = {
    auto_close = false, -- auto close when there are no items
    auto_open = false, -- auto open when there are items
    auto_preview = true, -- automatically open preview when on an item
    auto_refresh = true, -- auto refresh when open
    auto_jump = false, -- auto jump to the item when there's only one
    focus = true, -- Focus the window when opened
    restore = true, -- restores the last location in the list when opening
    follow = true, -- Follow the current item
    indent_guides = true, -- show indent guides
    max_items = 200, -- limit number of items that can be displayed per section
    multiline = true, -- render multi-line messages
    pinned = false, -- When pinned, the opened trouble window will be bound to the current buffer
    ---@type trouble.Window.opts
    win = {}, -- window options for the results window. Can be a split or a floating window.
    -- Window options for the preview window. Can be a split, floating window,
    -- or `main` to show the preview in the main editor window.
    ---@type trouble.Window.opts
    preview = {
      type = "main",
      -- when a buffer is not yet loaded, the preview window will be created
      -- in a scratch buffer with only syntax highlighting enabled.
      -- Set to false, if you want the preview to always be a real loaded buffer.
      scratch = true,
    },
    -- Throttle/Debounce settings. Should usually not be changed.
    ---@type table<string, number|{ms:number, debounce?:boolean}>
    throttle = {
      refresh = 20, -- fetches new data when needed
      update = 10, -- updates the window
      render = 10, -- renders the window
      follow = 100, -- follows the current item
      preview = { ms = 100, debounce = true }, -- shows the preview for the current item
    },
    -- Key mappings can be set to the name of a builtin action,
    -- or you can define your own custom action.
    ---@type table<string, string|trouble.Action>
    keys = {
      ["?"] = "help",
      r = "refresh",
      R = "toggle_refresh",
      q = "close",
      o = "jump_close",
      ["<esc>"] = "cancel",
      ["<cr>"] = "jump",
      ["<2-leftmouse>"] = "jump",
      ["<c-s>"] = "jump_split",
      ["<c-v>"] = "jump_vsplit",
      -- go down to next item (accepts count)
      -- j = "next",
      ["}"] = "next",
      ["]]"] = "next",
      -- go up to prev item (accepts count)
      -- k = "prev",
      ["{"] = "prev",
      ["[["] = "prev",
      i = "inspect",
      p = "preview",
      P = "toggle_preview",
      zo = "fold_open",
      zO = "fold_open_recursive",
      zc = "fold_close",
      zC = "fold_close_recursive",
      za = "fold_toggle",
      zA = "fold_toggle_recursive",
      zm = "fold_more",
      zM = "fold_close_all",
      zr = "fold_reduce",
      zR = "fold_open_all",
      zx = "fold_update",
      zX = "fold_update_all",
      zn = "fold_disable",
      zN = "fold_enable",
      zi = "fold_toggle_enable",
      gb = { -- example of a custom action that toggles the active view filter
        action = function(view)
          view.state.filter_buffer = not view.state.filter_buffer
          view:filter(view.state.filter_buffer and { buf = 0 } or nil)
        end,
        desc = "Toggle Current Buffer Filter",
      },
    },
    ---@type table<string, trouble.Mode>
    modes = {
      symbols = {
        desc = "document symbols",
        mode = "lsp_document_symbols",
        focus = false,
        win = { position = "right" },
        filter = {
          -- remove Package since luals uses it for control flow structures
          ["not"] = { ft = "lua", kind = "Package" },
          any = {
            -- all symbol kinds for help / markdown files
            ft = { "help", "markdown" },
            -- default set of symbol kinds
            kind = {
              "Class",
              "Constructor",
              "Enum",
              "Field",
              "Function",
              "Interface",
              "Method",
              "Module",
              "Namespace",
              "Package",
              "Property",
              "Struct",
              "Trait",
            },
          },
        },
      },
    },
    -- stylua: ignore
    icons = {
      ---@type trouble.Indent.symbols
      indent = {
        top           = "│ ",
        middle        = "├╴",
        last          = "└╴",
        -- last          = "-╴",
        -- last       = "╰╴", -- rounded
        fold_open     = " ",
        fold_closed   = " ",
        ws            = "  ",
      },
      folder_closed   = " ",
      folder_open     = " ",
      kinds = {
        Array         = " ",
        Boolean       = "󰨙 ",
        Class         = " ",
        Constant      = "󰏿 ",
        Constructor   = " ",
        Enum          = " ",
        EnumMember    = " ",
        Event         = " ",
        Field         = " ",
        File          = " ",
        Function      = "󰊕 ",
        Interface     = " ",
        Key           = " ",
        Method        = "󰊕 ",
        Module        = " ",
        Namespace     = "󰦮 ",
        Null          = " ",
        Number        = "󰎠 ",
        Object        = " ",
        Operator      = " ",
        Package       = " ",
        Property      = " ",
        String        = " ",
        Struct        = "󰆼 ",
        TypeParameter = " ",
        Variable      = "󰀫 ",
      },
    },
  },
}
