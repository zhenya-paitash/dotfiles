return {
  -- VIM-DADBOD
  config = {},

  -- VIM-DADBOD-UI
  UI = {
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_save_location = vim.fn.getcwd() .. "/sql/"
    end,
  },

  -- VIM-DADBOD-COMPLETION
  COMPLETION = {},
}
