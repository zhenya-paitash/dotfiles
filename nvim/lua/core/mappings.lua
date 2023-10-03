------------
-- CONFIG
------------
local Map = vim.keymap.set
local def_opt = { noremap = true, silent = true }
local expr_opt = { noremap = true, expr = true, silent = true }

-- RU
vim.cmd("set keymap=russian-jcukenwin")
vim.cmd("set iminsert=0")
vim.cmd("set imsearch=0")


------------
-- KEYMAPS
------------
vim.g.mapleader = " "

-- custom mapping
Map("n", "<leader>w", ":w<CR>")
Map("n", "<leader>h", ":nohlsearch<CR>")
Map("n", "<leader>a", "ggVGo", def_opt)

Map({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", expr_opt)
Map({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", expr_opt)
Map({ "n", "v" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", expr_opt)
Map({ "n", "v" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", expr_opt)

-- switch lines
Map("i", "<C-j>", "<Esc><cmd>m .+1<CR>==gi")
Map("i", "<C-k>", "<Esc><cmd>m .-2<CR>==gi")
Map("x", "J", ":m '>+1<CR>gv-gv", def_opt)
Map("x", "K", ":m '<-2<CR>gv-gv", def_opt)


------------
-- PLUGINS
------------
-- Neotree
Map("n", "<leader>e", ":Neotree left focus reveal_force_cwd<CR>")
Map("n", "<leader>o", ":Neotree float git_status<CR>")

-- LSP
Map("n", "<leader>ld", vim.diagnostic.setloclist)
Map("n", "<leader>lD", vim.diagnostic.open_float)
Map("n", "[d", vim.diagnostic.goto_prev)
Map("n", "]d", vim.diagnostic.goto_next)

-- Trouble
local Trouble = require("trouble")
Map("n", "<leader>tt", function() Trouble.open() end)
Map("n", "<leader>td", function() Trouble.open("document_diagnostics") end)
Map("n", "<leader>tw", function() Trouble.open("workspace_diagnostics") end)
Map("n", "<leader>tq", function() Trouble.open("quickfix") end)
Map("n", "<leader>tl", function() Trouble.open("loclist") end)
Map("n", "<leader>tr", function() Trouble.open("lsp_references") end)
Map("n", "<leader>t]", function() Trouble.next({ skip_groups = true, jump = true }) end)
Map("n", "<leader>t[", function() Trouble.previous({ skip_groups = true, jump = true }) end)

-- TODO
Map("n", "<leader>fo", ":TodoTelescope<CR>")
Map("n", "<leader>to", ":TodoTrouble<CR>")


-- Bufferline
Map("n", "<Tab>", ":BufferLineCycleNext<CR>")
Map("n", "<s-Tab>", ":BufferLineCyclePrev<CR>")
Map("n", "<leader>x", ":BufferLinePickClose<CR>")
Map("n", "<leader>X", ":BufferLineCloseOthers<CR>")
Map("n", "<leader>s", ":BufferLineSortByTabs<CR>")
Map("n", "<leader>s", ":BufferLineSortByTabs<CR>")
