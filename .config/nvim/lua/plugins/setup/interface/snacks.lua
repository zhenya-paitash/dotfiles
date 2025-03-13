return {
  ---@class snacks
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    scroll = {
      animate = {
        duration = { step = 10, total = 50 },
        easing = "linear",
      },
      spamming = 6, -- threshold for spamming detection
      -- what buffers to animate
      filter = function(buf)
        return vim.g.snacks_scroll ~= false and vim.b[buf].snacks_scroll ~= false and vim.bo[buf].buftype ~= "terminal"
      end,
    },
    image = { enabled = true },
  },
}
