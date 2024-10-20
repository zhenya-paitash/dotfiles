return {
  config = function()
    require("markview").setup {
      buf_ignore = { "nofile" },
      modes = { "n", "no" },

      options = {
        on_enable = {},
        on_disable = {},
      },

      block_quotes = {},
      checkboxes = {},
      code_blocks = {},
      headings = {},
      horizontal_rules = {},
      inline_codes = {},
      links = {},
      list_items = {},
      tables = {},
    }
  end,
}
