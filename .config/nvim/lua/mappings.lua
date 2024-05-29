require "nvchad.mappings"

local map = vim.keymap.set

local MODE = {
  normal = "n",
  insert = "i",
  visual = "v",
  visual_block = "x",
  term = "t",
  command = "c",
  operator = "o",
}

---------------------------------------
-- GENERAL
---------------------------------------
-- unbind save on <C-s> for TMUX
map({ MODE.normal, MODE.insert, MODE.visual }, "<C-s>", "", {})

-- MODE: normal
map(MODE.normal, "<leader>a", "ggVGo", { desc = "Select all", noremap = true, silent = true })
map(MODE.normal, "<leader>z", "zfS", { desc = "Create folder from ...", noremap = true, silent = true })
map(MODE.normal, "n", "nzzzv", { desc = "Next search", noremap = true, silent = true })
map(MODE.normal, "N", "Nzzzv", { desc = "Prev search", noremap = true, silent = true })
map(
  MODE.normal,
  "<F1",
  "<cmd>lua vim.lsp.buf.signature_help()<CR>",
  { desc = "Show signature help", noremap = true, silent = true }
)
map(MODE.normal, "<leader>w", "<cmd> w <CR>", { desc = "Save file", noremap = true, silent = true })
-- resize panels
map(
  MODE.normal,
  "<A-right>",
  "<cmd> :vertical resize +10 <CR>",
  { desc = "Resize right", noremap = true, silent = true }
)
map(MODE.normal, "<A-left>", "<cmd> :vertical resize -10 <CR>", { desc = "Resize left", noremap = true, silent = true })
map(MODE.normal, "<A-up>", "<cmd> :resize +10% <CR>", { desc = "Resize up", noremap = true, silent = true })
map(MODE.normal, "<A-down>", "<cmd> :resize -10% <CR>", { desc = "Resize down", noremap = true, silent = true })
map(MODE.normal, "<C-w>l", "<cmd> :vertical resize +15 <CR>", { desc = "Resize right", noremap = true, silent = true })
map(MODE.normal, "<C-w>h", "<cmd> :vertical resize -15 <CR>", { desc = "Resize left", noremap = true, silent = true })
map(MODE.normal, "<C-w>k", "<cmd> :resize +15% <CR>", { desc = "Resize up", noremap = true, silent = true })
map(MODE.normal, "<C-w>j", "<cmd> :resize -15% <CR>", { desc = "Resize down", noremap = true, silent = true })

-- MODE: visual
map(MODE.visual, ">", ">gv", { desc = "Indent left", noremap = true, silent = true })
map(MODE.visual, "<", "<gv", { desc = "Indent right", noremap = true, silent = true })
map(MODE.visual, "<leader>y", '"+y', { desc = "Copy sys", noremap = true, silent = true })
map(MODE.visual, "<C-c>", '"+y gv-gv', { desc = "Copy sys", noremap = true, silent = true })

-- MODE: insert
-- map(MODE.insert, "<C-c>", '"+y', { desc = "Copy sys", noremap = true, silent = true })
-- map(MODE.insert, "<C-j>", "<ESC> <cmd> m .+1 <CR> == gi", { desc = "Move line up", noremap = true, silent = true })
-- map(MODE.insert, "<C-k>", "<ESC> <cmd> m .-2 <CR> == gi", { desc = "Move line down", noremap = true, silent = true })
map(MODE.insert, "<F1>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { desc = "Show signature help" })

-- MODE: visual_block
map(MODE.visual_block, "J", ":m '>+1 <CR> gv-gv", { desc = "Move block down", noremap = true, silent = true })
map(MODE.visual_block, "K", ":m '<-2 <CR> gv-gv", { desc = "Move block up", noremap = true, silent = true })
-- map(MODE.visual_block, "<C-c>", "'+y gv", { desc = "Copy sys", noremap = true, silent = true })

---------------------------------------
-- TELESCOPE
---------------------------------------
-- MODE: normal
map(MODE.normal, "<leader><leader>", "<cmd> Telescope find_files <CR>", { desc = "Find files" })
map(MODE.normal, "<leader>gb", "<cmd> Telescope git_branches <CR>", { desc = "Git branch" })
-- map(MODE.normal, "<leader>ft", "<cmd> Telescope terms <CR>", { desc = "Find terms" })
map(MODE.normal, "<leader>*", "<cmd> Telescope grep_string <CR>", { desc = "Grep string" })

-- TODO: check how good it is
map(MODE.normal, "<leader>gr", "<cmd> Telescope lsp_references <CR>", { desc = "Find references" })
map(MODE.normal, "<leader>gd", "<cmd> Telescope lsp_definitions <CR>", { desc = "Find definitions" })
-- map(MODE.normal, "gr", "<cmd> Telescope lsp_references <CR>", { desc = "Find references" })
-- map(MODE.normal, "gd", "<cmd> Telescope lsp_definitions <CR>", { desc = "Find definitions" })

-- MODE: visual
map(MODE.visual, "<leader>*", "<cmd> Telescope grep_string <CR>", { desc = "Grep string" })

local trouble = require "trouble.providers.telescope"
require("telescope").setup {
  defaults = {
    mappings = {
      i = { ["<c-t>"] = trouble.open_with_trouble },
      n = { ["<c-t>"] = trouble.open_with_trouble },
    },
  },
}

---------------------------------------
-- TABUFLINE
---------------------------------------
-- MODE: normal
map(MODE.normal, "<leader>X", function()
  require("nvchad.tabufline").closeAllBufs()
  vim.cmd "NvimTreeFocus"
end, { desc = "Close other buffers", noremap = true, silent = true })

---------------------------------------
-- TROUBLE
---------------------------------------
-- INFO: syntax function() end start plugin
-- MODE: normal
map(MODE.normal, "<leader>t", function()
  require("trouble").open()
end, { desc = "Toggle trouble" })
map(MODE.normal, "<leader>td", function()
  require("trouble").open "document_diagnostics"
end, { desc = "Trouble document_diagnostics" })
map(MODE.normal, "<leader>tw", function()
  require("trouble").open "workspace_diagnostics"
end, { desc = "Trouble workspace_diagnostics" })
map(MODE.normal, "<leader>tq", function()
  require("trouble").open "quickfix"
end, { desc = "Trouble quickfix" })
map(MODE.normal, "<leader>tl", function()
  require("trouble").open "loclist"
end, { desc = "Trouble loclist" })
map(MODE.normal, "<leader>tr", function()
  require("trouble").open "lsp_references"
end, { desc = "Trouble lsp_references" })
map(MODE.normal, "<leader>t]", function()
  require("trouble").next { skip_groups = true, jump = true }
end, { desc = "Trouble next" })
map(MODE.normal, "<leader>t[", function()
  require("trouble").previous { skip_groups = true, jump = true }
end, { desc = "Trouble previous" })

---------------------------------------
-- FLASH
---------------------------------------
-- MODE: normal
-- INFO: this keybindings is here "./plugins/setup/flash.lua"
-- map({ MODE.normal, MODE.visual_block, MODE.operator }, "<leader>s", function()
--   require("flash").jump()
-- end, { desc = "Flash", noremap = true, silent = true })
-- map({ MODE.normal, MODE.visual_block, MODE.operator }, "<leader>S", function()
--   require("flash").treesitter()
-- end, { desc = "Flash Treesitter", noremap = true, silent = true })

---------------------------------------
-- TODOCOMMENTS
---------------------------------------
--MODE: normal
map(MODE.normal, "<leader>tt", "<cmd> TodoTrouble <CR>", { desc = "Todo Trouble", noremap = true, silent = true })
map(MODE.normal, "<leader>ft", "<cmd> TodoTelescope <CR>", { desc = "Todo Telescope", noremap = true, silent = true })

---------------------------------------
-- LAZYGIT
---------------------------------------
--MODE: normal
map(MODE.normal, "<leader>gl", "<cmd> LazyGit <CR>", { desc = "LazyGit" })

---------------------------------------
-- DAP
---------------------------------------
-- MODE: normal
map(MODE.normal, "<leader>ds", "<cmd>lua require('dap').continue()<CR>", { desc = "Start/Continue" })
map(MODE.normal, "<leader>dr", "<cmd>lua require('dap').repl.toggle()<CR>", { desc = "Toggle REPL" })
map(MODE.normal, "<leader>dR", "<cmd>lua require('dap').restart_frame()<CR>", { desc = "Restart" })
map(MODE.normal, "<leader>dq", "<cmd>lua require('dap').close()<CR>", { desc = "Close Session" })
map(MODE.normal, "<leader>dQ", "<cmd>lua require('dap').terminate()<CR>", { desc = "Terminate Session" })
map(MODE.normal, "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<CR>", { desc = "Toggle breakpoint" })
map(MODE.normal, "<leader>dB", "<cmd>lua require('dap').clear_breakpoints()<CR>", { desc = "Clear Breakpoints" })
map(MODE.normal, "<leader>di", "<cmd>lua require('dap').step_into()<CR>", { desc = "Step Into" })
map(MODE.normal, "<leader>do", "<cmd>lua require('dap').step_over()<CR>", { desc = "Step Over" })
map(MODE.normal, "<leader>dO", "<cmd>lua require('dap').step_out()<CR>", { desc = "Step Out" })
map(MODE.normal, "<leader>dp", "<cmd>lua require('dap').pause()<CR>", { desc = "Pause" })
map(MODE.normal, "<leader>dc", "<cmd>lua require('dap').run_to_cursor()<CR>", { desc = "Run to cursor" })

-- MODE: visual
map(MODE.visual, "<leader>dk", "<cmd>lua require('dapui').eval()<CR>", { desc = "Evaluate Input" })

---------------------------------------
-- DAP UI
---------------------------------------
-- MODE: normal
map(MODE.normal, "<leader>du", function()
  require("dapui").toggle()
end, { desc = "UI toggle", noremap = true, silent = true })
map(MODE.normal, "<leader>dK", function()
  vim.ui.input({ prompt = "Expression: " }, function(expr)
    if expr then
      require("dapui").eval(expr, { enter = true })
    end
  end)
end, { desc = "Evaluate Input", noremap = true, silent = true })
-- maps.n["<leader>du"] = { function() require("dapui").toggle() end, desc = "Toggle Debugger UI" }
-- maps.n["<leader>dh"] = { function() require("dap.ui.widgets").hover() end, desc = "Debugger Hover" }

---------------------------------------
-- PERSISTENCE
---------------------------------------
-- MODE: normal
map(MODE.normal, "<leader>qs", function()
  require("persistence").load()
  print "💾 session-load"
  -- TODO: notification
end, { desc = "Restore session for current dir" })
map(MODE.normal, "<leader>ql", function()
  require("persistence").load { last = true }
  print "🌍 session-load-last"
  -- TODO: notification
end, { desc = "Restore last session" })
map(MODE.normal, "<leader>qd", function()
  require("persistence").stop()
  print "❌ session-not-save"
  -- TODO: notification
end, { desc = "Stop session" })

---------------------------------------
-- DIFFVIEW
---------------------------------------
-- MODE: normal
map(MODE.normal, "<leader>gd", "<cmd> DiffviewOpen <CR>", { desc = "Git Diffview Open" })
map(MODE.normal, "<leader>gc", "<cmd> DiffviewClose <CR>", { desc = "Git Diffview Close" })

---------------------------------------
-- MARKDOWN PREVIEW
---------------------------------------
-- MODE: normal
map(MODE.normal, "<leader>mp", function()
  vim.cmd "MarkdownPreviewToggle"
  print "📑 Markdown Preview start."
  -- TODO: notification
end, { desc = "Markdown preview toggle" })

---------------------------------------
-- JSON
---------------------------------------
map(MODE.normal, "<leader>jq", ":%!jq '.'<CR>")

---------------------------------------
-- REST.NVIM
---------------------------------------
map(MODE.normal, "<leader>rr", "<cmd> Rest run <CR>", { desc = "Run request under the cursor" })
map(MODE.normal, "<leader>rl", "<cmd> Rest run last <CR>", { desc = "Run last request" })

