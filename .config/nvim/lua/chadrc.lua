-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "tundra",
  theme_toggle = { "tundra", "tundra" },
  transparency = false,
  lsp_semantic_tokens = true,
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
    CursorLineNr = { fg = "#789AE5" },
  },
  hl_add = {
    NvimTreeOpenedFolderName = { fg = "green", bold = true },
  },
}

M.ui = {
  statusline = {
    theme = "minimal",
    separator_style = "round",
  },
  tabufline = {
    -- enabled = false,
    -- lazyload = true,
  },
}

-- M.plugins = {
--   options = {},
--   ["nvim-telescope/telescope.nvim"] = function()
--     local telescope = require "telescope"
--     telescope.setup {
--       extensions = {
--         fzf = {
--           fuzzy = true, -- false will only do exact matching
--           override_generic_sorter = true, -- override the generic sorter
--           override_file_sorter = true, -- override the file sorter
--           case_mode = "smart_case", -- or "ignore_case" or "respect_case"
--         },
--       },
--     }
--
--     -- telescope.load_extension "fzf"
--     -- print "Telescope fzf extension loaded"
--   end,
-- }

return M
