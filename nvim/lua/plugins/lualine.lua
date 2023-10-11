require("lualine").setup {
  options = {
    theme = "catppuccin",
    component_separators = "",
    section_separators = { left = "", right = "" }
  },
  sections = {
    lualine_a = { { "mode", separator = { left = "", right = "" }, right_padding = 2 } },
    lualine_b = { "branch", "diff" },
    lualine_c = { "filename", "diagnostics" },
    lualine_x = { "searchcount", "fileformat", "encoding" },
    lualine_y = { "filetype", "progress" },
    lualine_z = { { "location", separator = { left = "", right = "" }, left_padding = 2 } },
  },
  inactive_sections = {
    lualine_a = { "filename" },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { "location" }
  },
  tabline = {},
  extensions = {}
}

vim.cmd([[
augroup lualine_augroup
  autocmd!
  autocmd User LspProgressStatusUpdated lua require("lualine").refresh()
augroup END
]])
