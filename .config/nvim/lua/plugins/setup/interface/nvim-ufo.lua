return {
  config = function()
    vim.o.foldcolumn = "0" -- '0' is not bad
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    -- vim.o.foldenable = true

    vim.keymap.set("n", "zR", require("ufo").openAllFolds)
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
    vim.keymap.set("n", "zK", function()
      local winid = require("ufo").peekFoldedLinesUnderCursor()
      if not winid then
        vim.lsp.buf.hover()
      end
    end, { desc = "Peek Fold" })

    require("ufo").setup {
      provider_selector = function(bufnr, filetype, buftype)
        -- disable `ufo` for `DBUI`
        if filetype == "dbui" then
          return ""
        end

        return { "treesitter", "indent" }
        -- return { "lsp", "indent" }
      end,
    }
  end,
}
