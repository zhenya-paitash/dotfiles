return {
  -- @repo: https://github.com/sphamba/smear-cursor.nvim?tab=readme-ov-file#using-lazynvim-1
  -- @config: https://github.com/sphamba/smear-cursor.nvim/blob/main/lua/smear_cursor/config.lua
  opts = {                         -- Default  Range
    stiffness = 0.8,               -- 0.6      [0, 1]
    trailing_stiffness = 0.5,      -- 0.3      [0, 1]
    distance_stop_animating = 0.5, -- 0.1      > 0
    hide_target_hack = false,      -- true     boolean

    -- @see: https://github.com/sphamba/smear-cursor.nvim?tab=readme-ov-file#transparent-background
    -- @desc: для прозрачного фона
    -- legacy_computing_symbols_support = true,
    -- transparent_bg_fallback_color = "#303030",
  },
}
