return {
  config = function()
    -- config: https://github.com/RRethy/vim-illuminate?tab=readme-ov-file#configuration
    require("illuminate").configure {}

    local hl = vim.api.nvim_get_hl_by_name("Visual", true)
    local bg = hl.background and string.format("#%06x", hl.background) or nil
    if bg then
      vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = bg })
      vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = bg })
    end
  end,
}
