-- WARN: set not to use default vim swap files mode
vim.g.noswapfile = true

vim.g.did_load_filetypes = 1
vim.g.formatoptions = "qrn1"
vim.opt.showmode = false
vim.opt.updatetime = 120
vim.wo.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.wrap = false
vim.wo.linebreak = true
vim.opt.virtualedit = "block"
vim.opt.undofile = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

-- Mouse
vim.opt.mouse = "a"
vim.opt.mousefocus = true

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Shorter messages
vim.opt.shortmess:append("c")

-- Indent Settings
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true

-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Width line
-- vim.opt.textwidth = 120
-- vim.api.nvim_set_option_value("colorcolumn", "120", {})

-- Left line numbers
vim.wo.number = true
vim.wo.relativenumber = true
-- Left line HL current line
-- vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#313131" })
-- vim.api.nvim_set_hl(0, "LineNr", { fg = "white" })
-- vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#313131" })

-- Fillchars
vim.opt.fillchars = {
  vert = "│",
  fold = "⠀",
  eob = " ", -- suppress ~ at EndOfBuffer
  -- diff = "⣿", -- alternatives = ⣿ ░ ─ ╱
  msgsep = "‾",
  foldopen = "▾",
  foldsep = "│",
  foldclose = "▸"
}
