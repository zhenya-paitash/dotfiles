require "nvchad.options"

local o = vim.o
local autocmd = vim.api.nvim_create_autocmd
-- local cmd = vim.cmd

--┌───────────┬─────────────────────────────────────────────────────────────┐
--├ @catecory   Options
--└───────────┴─────────────────────────────────────────────────────────────┘
o.relativenumber = true
o.wrap = false
o.whichwrap = "[,]"
o.cursorlineopt = "both"
o.termguicolors = true
o.scrolloff = 5
o.clipboard = "" -- "unnamedplus"
o.inccommand = "split"

-- `NOTE` options
o.conceallevel = 2 -- Obsidian markdown syntax
o.spelllang = "en,ru"

-- colors
-- cmd "highlight link CurSearch IncSearch"
-- cmd "hi CursorLineNr guifg=#ED9455"
vim.api.nvim_set_hl(0, "MiniCursorword", { link = "LspReferenceText" })

--┌───────────┬─────────────────────────────────────────────────────────────┐
--├ @catecory   Custom Functions
--└───────────┴─────────────────────────────────────────────────────────────┘
-- autoread buffer
o.autoread = true
autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

-- highlight when yanking (copying) text
-- NOTE: don't need with plugin `gbprod/yanky.nvim`
-- vim.api.nvim_create_autocmd("TextYankPost", {
--   desc = "Highlight when yanking (copying) text",
--   group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
--   callback = function()
--     vim.highlight.on_yank()
--   end,
-- })
