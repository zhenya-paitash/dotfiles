return {
  config = function()
    vim.g.maplocalleader = ","
    require("grug-far").setup {}
  end,
}
