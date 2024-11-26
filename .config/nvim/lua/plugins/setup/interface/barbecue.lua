return {
  config = function()
    local fg_left = COLORS.primary
    local fg_right = COLORS.primary_ghost
    local fg_icons = COLORS.secondary
    local fg_symbols = COLORS.secondary
    -- local fg_left = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Comment")), "fg")
    -- local fg_left = "#AF8260"
    -- local fg_right = "#AF8260"
    -- local fg_icons = "#ED9455"
    -- local fg_symbols = "#FFEC9E"

    -- *EVERFOREST THEME*
    -- local fg_left = "#D3C6AA"
    -- local fg_right = "#D9BA7E"
    -- local fg_icons = "#82BE91"
    -- local fg_symbols = "#3C4841"

    -- *YsDark THEME*
    -- local fg_left = "#6A97BD"
    -- local fg_icons = "#789AE5"
    -- local fg_right = "#C3A4B0"
    -- local fg_symbols = "#C3A4B0"

    -- vim.cmd("hi CursorLineNr guifg=" .. fg_icons)

    require("barbecue").setup {
      theme = {
        -- this highlight is used to override other highlights
        -- you can take advantage of its `bg` and set a background throughout your winbar
        -- (e.g. basename will look like this: { fg = "#c-1caf5", bold = true })
        normal = { fg = fg_right },

        -- these highlights correspond to symbols table from config
        ellipsis = { fg = fg_symbols },
        separator = { fg = fg_symbols },
        modified = { fg = fg_symbols },

        -- these highlights represent the _text_ of three main parts of barbecue
        dirname = { fg = fg_left, italic = true },
        basename = { fg = fg_icons, bold = true },
        context = {},

        -- these highlights are used for context/navic icons
        context_file = { fg = fg_icons },
        context_module = { fg = fg_icons },
        context_namespace = { fg = fg_icons },
        context_package = { fg = fg_icons },
        context_class = { fg = fg_icons },
        context_method = { fg = fg_icons },
        context_property = { fg = fg_icons },
        context_field = { fg = fg_icons },
        context_constructor = { fg = fg_icons },
        context_enum = { fg = fg_icons },
        context_interface = { fg = fg_icons },
        context_function = { fg = fg_icons },
        context_variable = { fg = fg_icons },
        context_constant = { fg = fg_icons },
        context_string = { fg = fg_icons },
        context_number = { fg = fg_icons },
        context_boolean = { fg = fg_icons },
        context_array = { fg = fg_icons },
        context_object = { fg = fg_icons },
        context_key = { fg = fg_icons },
        context_null = { fg = fg_icons },
        context_enum_member = { fg = fg_icons },
        context_struct = { fg = fg_icons },
        context_event = { fg = fg_icons },
        context_operator = { fg = fg_icons },
        context_type_parameter = { fg = fg_icons },
      },
    }
  end,
}
