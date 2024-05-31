return {
  config = function()
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      virtual_text = {
        spacing = 5,
        -- severity_limit = "Warning",  -- TODO: remove this in neovim 0.11
        min = "severity",
      },
      update_in_insert = true,
    })
  end,
}

