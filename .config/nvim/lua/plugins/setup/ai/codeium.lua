return {
  config = function()
    -- disable `codeium` default keybindings
    vim.g.codeium_disable_bindings = 1

    vim.keymap.set("i", "<C-f>", function()
      return vim.fn["codeium#Accept"]()
    end, { expr = true, silent = true })
    vim.keymap.set("i", "<C-x>", function()
      return vim.fn["codeium#Clear"]()
    end, { expr = true, silent = true })
  end,
}
