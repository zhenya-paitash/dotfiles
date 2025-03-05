return {
  -- @link: https://github.com/iamcco/markdown-preview.nvim?tab=readme-ov-file#markdownpreview-config
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }

    vim.g.mkdp_auto_close = 0
    vim.g.mkdp_combine_preview = 1
    -- vim.g.mkdp_combine_preview_auto_refresh = 1

    -- @desc: pass CLI options to the browser, like opening in a new window
    -- @link: https://github.com/iamcco/markdown-preview.nvim?tab=readme-ov-file#how-can-i-pass-cli-options-to-the-browser-like-opening-in-a-new-window
    vim.cmd [[
      function! OpenMarkdownPreview(url)
        " execute 'silent ! brave --new-window ' . shellescape(a:url)
        execute 'silent ! zen-browser -private-window ' . shellescape(a:url)
      endfunction
    ]]
    vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
  end,
}
