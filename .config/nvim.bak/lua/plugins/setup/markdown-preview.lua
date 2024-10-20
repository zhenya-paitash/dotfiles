return {
  build = function()
    vim.fn["mkdp#util#install"]()
  end,

  init = function()
    -- " set to 1, the nvim will auto close current preview window when changing
    -- " from Markdown buffer to another buffer
    -- " default: 1
    vim.g.mkdp_auto_close = 0

    -- " default: 0
    -- " if enable it will reuse previous opened preview window when you preview markdown file.
    -- " ensure to set let g:mkdp_auto_close = 0 if you have enable this option
    vim.g.mkdp_combine_preview = 1

    -- " auto refetch combine preview contents when change markdown buffer
    -- " only when g:mkdp_combine_preview is 1
    vim.g.mkdp_combine_preview_auto_refresh = 1

    -- vim.g.mkdp_browserfunc = ":!firefox --new-window<CR>"
  end,
}
