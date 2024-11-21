return {
  -- keys = {
  --   { "<leader>cc", "<cmd>CodeSnap<cr>", mode = "x", desc = "Save selected code snapshot into clipboard" },
  --   { "<leader>cs", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot in ~/Pictures" },
  --   { "<leader>ch", "<cmd>CodeSnapHighlight<cr>", mode = "x", desc = "Save selected code snapshot into clipboard" },
  --   { "<leader>cv", "<cmd>CodeSnapSaveHighlight<cr>", mode = "x", desc = "Save selected code snapshot in ~/Pictures" },
  -- },

  opts = {
    save_path = "~/Downloads",

    bg_theme = "bamboo",
    watermark = "github.com/zhenya-paitash",
    has_line_number = true,
    has_breadcrumbs = true,
    -- breadcrumbs_separator = " > ",
  },
}
