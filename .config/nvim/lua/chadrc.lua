-- This file  needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
	theme = "wombat",
  theme_toggle = { "wombat", "wombat" },
  transparency = false,
  lsp_semantic_tokens = true,
  statusline = {
    theme = "minimal",
    separator_style = "round",
  },


	hl_override = {
		Comment = { italic = true },
		["@comment"] = { italic = true },
	},
  hl_add = {
    NvimTreeOpenedFolderName = { fg = "green", bold = true },
  }
}

return M
