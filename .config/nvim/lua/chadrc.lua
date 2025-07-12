-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "aquarium",
  theme_toggle = { "aquarium", "aquarium" },
  transparency = false,
  -- lsp_semantic_tokens = true,
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
    CursorLineNr = { fg = COLORS.primary },
  },
  hl_add = {
    NvimTreeOpenedFolderName = { fg = "green", bold = true },
  },
  terminal = {
    esc_termmode = { "jk" }, -- multiple mappings allowed
  },
}

M.ui = {
  cmp = { format_colors = { tailwind = true } },
  statusline = { theme = "minimal", separator_style = "round" },

  -- telescope = {
  --   style = "bordered", -- borderless | bordered
  -- },
  -- tabufline = {
  --   enabled = false,
  --   lazyload = true,
  -- },
}

return M
