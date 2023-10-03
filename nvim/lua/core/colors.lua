vim.opt.termguicolors = true

function SetColor(color)
  if color == "catppuccin" then
    require("themes.catppuccin")
  end

  vim.cmd.colorscheme(color)
end

SetColor("catppuccin")
