return {
  -- VIM-DADBOD
  config = {},

  -- VIM-DADBOD-UI
  UI = {
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_save_location = vim.fn.stdpath "config" .. "/sql/"
      -- vim.g.db_ui_save_location = vim.fn.getcwd() .. "/sql/"

      -- @desc `nvim-cmp` integration
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "sql",
        callback = function()
          vim.b.db_execute_on_save = 0
          require("cmp").setup.buffer {
            sources = {
              { name = "vim-dadbod-completion" },
            },
          }
        end,
      })
    end,
  },

  -- VIM-DADBOD-COMPLETION
  COMPLETION = {},
}
