-- INFO: https://github.com/mg979/vim-visual-multi/wiki/1.-Cursor-mode-vs-Extend-mode

return {
  keys = { "\\\\\\", "<F2>" },

  init = function()
    -- vim.g.VM_default_mappings = true
    vim.g.VM_mouse_mappings = 1

    -- vim.g.VM_Mono_hl = "DiffText"
    -- vim.g.VM_Extend_hl = "DiffAdd"
    -- vim.g.VM_Cursor_hl = "Visual"
    -- vim.g.VM_Cursor_hl = "hi! link Search PmenuSel"
    -- vim.g.VM_Insert_hl = "DiffChange"
    -- vim.g.VM_highlight_matches = 'hi! link Search PmenuSel'

    vim.g.VM_theme = "sand"

    vim.g.VM_maps = {
      ["Find Under"] = "<F2>",
    }
  end,
}
