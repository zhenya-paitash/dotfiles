---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "wombat",
  theme_toggle = { "wombat", "ayu_light" },

  hl_override = highlights.override,
  hl_add = highlights.add,

  statusline = {
    separator_style = "round",
  }
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
