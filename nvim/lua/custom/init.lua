local autocmd = vim.api.nvim_create_autocmd

-- swap files
-- vim.opt.directory="./"
-- vim.opt.swapfile = false

-- custom config
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.whichwrap = "[,]"

-- clipboard
vim.cmd 'set clipboard="unnamedplus"'
local in_wsl = os.getenv "WSL_DISTRO_NAME" ~= nil
if in_wsl then
  vim.g.clipboard = {
    name = "wsl clipboard",
    copy = { ["+"] = { "clip.exe" }, ["*"] = { "clip.exe" } },
    paste = { ["+"] = { "nvim_paste" }, ["*"] = { "nvim_paste" } },
    cache_enabled = true,
  }
end

-- Netrw File Explorer config
-- vim.g.netrw_banner = 0 -- Hide banner
-- vim.g.netrw_liststyle = 3 -- Tree plain view
-- vim.g.netrw_browse_split = 3 -- Open in previous window

-- highlight colors
vim.cmd "highlight link CurSearch IncSearch"

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
--     -- highlight current search
--     local search = vim.api.nvim_exec("highlight IncSearch", true)
--     local search_bg = search:match "guibg=(#[%x]+)"
--     local search_fg = search:match "guifg=(#[%x]+)"
--     vim.api.nvim_set_hl(0, "CurSearch", { bg = search_bg, fg = search_fg })
--
--     -- vim.api.nvim_set_hl(0, "CursorLineNr", { cterm = "bold", bold = true })
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
