local autocmd = vim.api.nvim_create_autocmd

-- swap files
-- vim.opt.directory="./"
-- vim.opt.swapfile = false

-- custom config
vim.opt.relativenumber = true
vim.opt.wrap = false

-- Netrw File Explorer config
-- vim.g.netrw_banner = 0 -- Hide banner
-- vim.g.netrw_liststyle = 3 -- Tree plain view
-- vim.g.netrw_browse_split = 3 -- Open in previous window

------------
-- AUTOCOMMAND
------------
-- autoread buffer
vim.o.autoread = true
autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

-- autochange color after chande colorscheme
-- autocmd({ "ColorScheme" }, {
--   pattern = "*",
--   callback = function()
--     vim.api.nvim_set_hl(0, "CursorLineNr", { cterm = "bold", bold = true })
--   end,
-- })

-- autosave file (alpha v)
-- autocmd({ "TextChanged", "TextChangedI" }, {
--   command = ":write",
--   pattern = { "*.js", "*.ts", "*.jsx", "*.tsx" },
-- })

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
