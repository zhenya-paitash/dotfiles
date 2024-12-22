return {
  { -- UI
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = require("plugins.ui.snacks").opts,
  },
}
