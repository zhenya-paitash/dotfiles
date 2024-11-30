return {
  config = function()
    require("fzf-lua").setup {
      -- Настройки fzf-lua
      winopts = {
        preview = {
          default = "bat", -- Используем bat для предпросмотра
          border = "rounded",
        },
      },
      fzf_bin = "/usr/bin/fzf", -- Указываем системный бинарник fzf
      previewers = {
        bat = {
          cmd = "bat",
          args = "--style=numbers,changes --color=always --line-range :500",
        },
      },
    }
  end,
}
