return {
  config = function()
    -- ?: replace to `options.lua`
    vim.g.maplocalleader = ','

    require("grug-far").setup {}
  end,
}
