return {
  config = function()
    require("duckytype").setup {
      expected = "english_common",
      number_of_words = 40,
      -- average_word_length = 5.69,

      window_config = {
        border = "rounded",
      },
      highlight = {
        good = "Comment",
        bad = "Error",
        remaining = "Todo",
      },
    }
  end,
}
