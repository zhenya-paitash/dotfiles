---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "tomorrow_night",
  theme_toggle = { "tomorrow_night", "one_light" },
  transparency = false,
  lsp_semantic_tokens = true,

  hl_override = highlights.override,
  hl_add = highlights.add,

  statusline = {
    -- theme = "minimal", -- default/vscode/vscode_colored/minimal
    -- separator_style = "round", -- default/round/block/arrow separators work only for default statusline theme
    theme = "vscode_colored",
    separator_style = "block",
  },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
