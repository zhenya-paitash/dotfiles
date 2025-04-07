return {
  config = function()
    local dm = require "debugmaster"
    vim.keymap.set({ "n", "t", "v" }, "<leader>dd", dm.mode.toggle, { nowait = true })
    vim.keymap.set("t", "<C-/>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

    -- Example keymap modification:
    dm.keys.get("q").key = "O"
  end,
}
