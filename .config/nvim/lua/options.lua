require "nvchad.options"

local o = vim.o
-- local cmd = vim.cmd
local autocmd = vim.api.nvim_create_autocmd

-- options
o.relativenumber = true
o.wrap = false
o.whichwrap = "[,]"
o.cursorlineopt = "both"
o.termguicolors = true
o.scrolloff = 5
o.clipboard = "" -- "unnamedplus"
o.inccommand = "split"
o.conceallevel = 2 -- Obsidian markdown syntax

-- colors
-- cmd "highlight link CurSearch IncSearch"
-- cmd "hi CursorLineNr guifg=#ED9455"

---- autoread buffer
o.autoread = true
autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

-- highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

