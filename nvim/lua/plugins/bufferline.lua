require("bufferline").setup {
  highlights = require("catppuccin.groups.integrations.bufferline").get(),

  options = {
    mode = "buffers",

    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      return "(" .. count .. ")"
    end,

    indicator = {
      -- icon = "| ", -- this should be omitted if indicator style is not "icon"
      -- style = "icon"
    },

    separator_style = "thick",
    -- separator_style = {'', ''},

    show_buffer_close_icons = true,
    buffer_close_icon = "",
    hover = {
      enabled = true,
      delay = 200,
      reveal = {
        "close",
      }
    },

    offsets = {
      {
        filetype = "neo-tree",
        text = "File Explorer",
        separator = true,
        padding = 0
      }
    },

  },
}
