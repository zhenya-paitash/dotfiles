return {
  opts = {
    -- cursor_applying_provider = "groq", -- In this example, use Groq for applying, but you can also use any provider you want.
    -- auto_suggestions_provider = "groq",
    -- behaviour = {
    --   enable_cursor_planning_mode = true, -- enable cursor planning mode!
    -- },
    provider = "groq",
    providers = {
      groq = { -- define groq provider
        __inherited_from = "openai",
        api_key_name = "GROQ_API_KEY",
        endpoint = "https://api.groq.com/openai/v1/",
        -- model = "llama-3.3-70b-versatile",
        model = "llama-3.1-8b-instant",
      },
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

-- @example: OLD CONFIG
-- return {
--   -- full config: https://github.com/yetone/avante.nvim/blob/main/lua/avante/config.lua
--   ---@class avante.Config
--   opts = {
--     ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "vertex" | "cohere" | "copilot" | string
--     provider = "openai",
--     auto_suggestions_provider = "groq",
--     cursor_applying_provider = "groq", -- In this example, use Groq for applying, but you can also use any provider you want.
--     behaviour = {
--       --- ... existing behaviours
--       enable_cursor_planning_mode = true, -- enable cursor planning mode!
--     },
--     openai = {
--       -- @provider: groq
--       -- @models: https://console.groq.com/docs/models
--       api_key_name = "OPENAI_API_KEY", -- @api_key: OPENAI_API_KEY
--       endpoint = "https://api.groq.com/openai/v1/",
--       model = "llama-3.3-70b-versatile", -- @limit: 8.192 tokens
--     },
--
--     ---@type {[string]: AvanteProvider}
--     vendors = {
--       ---@type AvanteSupportedProvider
--       ["groq"] = {
--         __inherited_from = "openai",
--         api_key_name = "GROQ_API_KEY",
--         endpoint = "https://api.groq.com/openai/v1/",
--         model = "llama-3.3-70b-versatile",
--         max_tokens = 32768, -- remember to increase this value, otherwise it will stop generating halfway
--       },
--       ["openai-mixtral"] = {
--         __inherited_from = "openai",
--         api_key_name = "ANTHROPIC_API_KEY", -- @api_key: ANTHROPIC_API_KEY
--         model = "mixtral-8x7b-32768",
--       },
--       ["openai-llama-3.1"] = {
--         __inherited_from = "openai",
--         api_key_name = "ANTHROPIC_API_KEY", -- @api_key: ANTHROPIC_API_KEY
--         model = "llama-3.1-70b-versatile", -- @limit: 32,768 tokens
--       },
--     },
--
--     mappings = {
--       ---@class AvanteConflictMappings
--       submit = {
--         normal = "<CR>",
--         insert = "<c-l>",
--       },
--     },
--   },
-- }
