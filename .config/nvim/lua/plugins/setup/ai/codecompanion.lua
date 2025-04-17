return {
  config = function()
    require("codecompanion").setup {
      strategies = {
        chat = { adapter = "deepseek" },
        inline = { adapter = "deepseek" },
      },
      adapters = {
        deepseek = function()
          return require("codecompanion.adapters").extend("deepseek", {
            env = {
              api_key = vim.env.DEEPSEEK_API_KEY,
            },
          })
        end,
      },
    }
  end,
}
