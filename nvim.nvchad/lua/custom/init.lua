local autocmd = vim.api.nvim_create_autocmd


vim.opt.relativenumber = true
vim.opt.wrap = false

-- Netrw File Explorer config
-- vim.g.netrw_banner = 0 -- Hide banner
-- vim.g.netrw_liststyle = 3 -- Tree plain view
-- vim.g.netrw_browse_split = 3 -- Open in previous window

-- autoread buffer
vim.o.autoread = true
autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
