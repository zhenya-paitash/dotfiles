return {
  config = function()
    vim.o.foldcolumn = "0" -- '0' is not bad
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    vim.keymap.set("n", "zR", require("ufo").openAllFolds)
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

    require("ufo").setup {
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end,
    }

    -- local cmd = vim.cmd
    -- cmd "hi default UfoFoldedFg guifg=Normal.foreground"
    -- cmd "hi default UfoFoldedBg guibg=Folded.background"
    -- cmd "hi default link UfoPreviewSbar PmenuSbar"
    -- cmd "hi default link UfoPreviewThumb PmenuThumb"
    -- cmd "hi default link UfoPreviewWinBar UfoFoldedBg"
    -- cmd "hi default link UfoPreviewCursorLine Visual"
    -- cmd "hi default link UfoFoldedEllipsis Comment"
    -- cmd "hi default link UfoCursorFoldedLine CursorLine"
  end,
}
