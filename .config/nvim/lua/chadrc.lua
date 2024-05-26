-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "solarized_dark",
  theme_toggle = { "solarized_dark", "solarized_dark" },
  transparency = false,
  lsp_semantic_tokens = true,
  statusline = {
    theme = "minimal",
    separator_style = "round",
  },

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
    CursorLineNr = { fg = "#ED9455" },
  },
  hl_add = {
    NvimTreeOpenedFolderName = { fg = "green", bold = true },
  },

  changed_themes = {
    solarized_dark = {
      base_30 = {
        white = "#ebdbb2",
        darker_black = "#141617",
        black = "#141617",
        black2 = "#191b1c",
        one_bg = "#1d2021",
        one_bg2 = "#292929",
        one_bg3 = "#404040",
        grey = "#4d4d4d",
        grey_fg = "#595959",
        grey_fg2 = "#928374",
        light_grey = "#a89984",
        red = "#ea6962",
        baby_pink = "#ea6962",
        pink = "#d3869b",
        line = "#404040",
        green = "#89b482",
        vibrant_green = "#a9b665",
        nord_blue = "#6f8faf",
        blue = "#6d8dad",
        yellow = "#d6b676",
        sun = "#d1b171",
        purple = "#9385b4",
        dark_purple = "#887aa9",
        teal = "#7daea3",
        orange = "#e78a4e",
        cyan = "#82b3a8",
        statusline_bg = "#222526",
        lightbg = "#2d3031",
        pmenu_bg = "#89b482",
        folder_bg = "#6d8dad",
      },

      base_16 = {
        base00 = "#1D1F21",
        base01 = "#2c2f30",
        base02 = "#36393a",
        base03 = "#404344",
        base04 = "#d4be98",
        base05 = "#B37655",
        base06 = "#c3b499",
        base07 = "#c7b89d",
        base08 = "#6FA196",
        base09 = "#BB7688",
        base0A = "#e0c080",
        base0B = "#789D73",
        base0C = "#D24A47",
        base0D = "#8C9A62",
        base0E = "#D55E5D",
        base0F = "#B0A27E",
      },

      base46 = {
        integrations = {
          "blankline",
          "cmp",
          "git",
          -- more
        },
      },

      --
    },
  },
}

return M
