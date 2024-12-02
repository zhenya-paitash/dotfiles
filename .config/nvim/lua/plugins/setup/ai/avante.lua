return {
  -- full config: https://github.com/yetone/avante.nvim/blob/main/lua/avante/config.lua
  ---@class avante.Config
  opts = {
    ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "vertex" | "cohere" | "copilot" | string
    provider = "openai",
    auto_suggestions_provider = "openai",
    ---@type AvanteSupportedProvider
    openai = {
      -- @provider: groq
      -- @models: https://console.groq.com/docs/models
      endpoint = "https://api.groq.com/openai/v1",
      model = "llama-3.1-70b-versatile", -- @limit: 32,768 tokens
      -- model = "gemma2-9b-it", -- @limit: - tokens
    },

    mappings = {
      ---@class AvanteConflictMappings
      submit = {
        normal = "<CR>",
        insert = "<c-l>",
      },
    },
  },
}
