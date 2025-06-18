return {
  -- VIM-DADBOD
  config = {},

  -- VIM-DADBOD-UI
  UI = {
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_save_location = vim.fn.stdpath "config" .. "/sql/"
      -- vim.g.db_ui_save_location = vim.fn.getcwd() .. "/sql/"

      -- @desc: `nvim-cmp` integration
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "sql",
        callback = function()
          -- @desc: custom save sql history
          local dir = vim.fn.expand("~/.config/nvim/sql/history/")
          if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, "p")
          end
          local filename = vim.fn.expand("%:t")
          local timestamp = os.date("%Y-%m-%d_%H-%M-%S")
          local path = dir .. filename .. "_" .. timestamp .. ".sql"
          vim.cmd("w! " .. path)

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
