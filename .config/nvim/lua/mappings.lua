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
-- restore default <C-i> mapping
-- map(MODE.normal, "<C-i>", "<C-i>", { noremap = true, silent = true })
map(MODE.normal, "<Tab>", "<C-i>", { noremap = true, silent = true })
map(MODE.normal, "<S-Tab>", ":bnext<CR>", { noremap = true, silent = true })

-- unbind <C-s> [reason: i'm using <C-s> as a leader for TMUX]
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
map(MODE.normal, "<leader><leader>", "<cmd> Telescope find_files <CR>", { desc = "find files (Telescope)" })
map(MODE.normal, "<leader>fs", "<cmd> Telescope lsp_document_symbols <CR>", { desc = "document symbols (Telescope)" })
map(MODE.normal, "<leader>gb", "<cmd> Telescope git_branches <CR>", { desc = "git branch (Telescope)" })
map(MODE.normal, "<leader>*", "<cmd> Telescope grep_string <CR>", { desc = "grep string (Telescope)" })
map(MODE.normal, "<leader>gr", "<cmd> Telescope lsp_references <CR>", { desc = "find references (Telescope)" })
map(MODE.normal, "<leader>gd", "<cmd> Telescope lsp_definitions <CR>", { desc = "find definitions (Telescope)" })
map(MODE.normal, "<leader><Tab>", function()
  local actions = require "telescope.actions"
  -- local actions_state = require "telescope.actions.state"

  require("telescope.builtin").buffers {
    prompt_title = "Buffers",
    previewer = false, -- отключаем предварительный просмотр
    -- sort_lastused = true, -- сортируем по последнему использованию
    sorter = require("telescope.config").values.generic_sorter {},
    layout_config = { width = 0.3, height = 0.25 },
    -- finder = require("telescope.finders").new_table {
    --   results = vim.fn.getbufinfo { buflisted = 1 },
    --   entry_maker = function(entry)
    --     if entry.bufnr == vim.api.nvim_get_current_buf() then
    --       return nil -- пропускаем текущий буфер
    --     end
    --     return {
    --       value = entry,
    --       display = entry.name,
    --       ordinal = entry.bufnr .. " " .. entry.name,
    --     }
    --   end,
    -- },

    attach_mappings = function(prompt_bufnr, buf_map)
      buf_map("i", "<esc>", actions.close)
      buf_map("i", "<Tab>", actions.move_selection_next)
      buf_map("i", "<S-Tab>", actions.move_selection_previous)
      buf_map("n", "<Tab>", actions.move_selection_next)
      buf_map("n", "<S-Tab>", actions.move_selection_previous)
      return true
    end,
  }
end, { desc = "buffers (Telescope)" })

-- MODE: visual
map(MODE.visual, "<leader>*", "<cmd> Telescope grep_string <CR>", { desc = "grep string (Telescope)" })

---------------------------------------
-- TROUBLE
---------------------------------------
-- TELESCOPE + TROUBLE
local trouble_open = require("trouble.sources.telescope").open
require("telescope").setup {
  defaults = {
    mappings = {
      i = { ["<c-t>"] = trouble_open },
      n = { ["<c-t>"] = trouble_open },
    },
  },
}

-- -- MODE: normal
-- map(MODE.normal, "<leader>t]", function()
--   require("trouble").next { skip_groups = true, jump = true }
-- end, { desc = "Trouble next" })
-- map(MODE.normal, "<leader>t[", function()
--   require("trouble").previous { skip_groups = true, jump = true }
-- end, { desc = "Trouble previous" })
map(MODE.normal, "<leader>t", "<cmd> Trouble <CR>", { desc = "Trouble" })
-- 1: Diagnostics (diagnostics)
map(MODE.normal, "<leader>td", "<cmd> Trouble diagnostics toggle <CR>", { desc = "diagnostics (Trouble)" })
map(
  MODE.normal,
  "<leader>tD",
  "<cmd> Trouble diagnostics toggle filter.buf=0 <CR>",
  { desc = "diagnostics buffer (Trouble)" }
)
-- 2: Location List (loclist)
map(MODE.normal, "<leader>tl", "<cmd> Trouble loclist toggle <CR>", { desc = "loclist (Trouble)" })
-- 3: LSP definitions, references, implementations, type definitions, and declarations (lsp)
map(
  MODE.normal,
  "<leader>tl",
  "<cmd> Trouble lsp toggle focus=false win.position=right <CR>",
  { desc = "lsp def/ref/... (Trouble)" }
)
-- 4: Declarations (lsp_declarations)
-- 5: Definitions (lsp_definitions)
-- 6: Document symbols (lsp_document_symbols)
map(
  MODE.normal,
  "<leader>ts",
  "<cmd> Trouble lsp_document_symbols toggle focus=false win.position=right <CR>",
  { desc = "lps symbols (Trouble)" }
)
-- 7: Implementations (lsp_implementations)
-- 8: Incoming Calls (lsp_incoming_calls)
-- 9: Outgoing Calls (lsp_outgoing_calls)
-- 10: References (lsp_references)
-- 11: Type definitions (lsp_type_definitions)
-- 12: Quickfix List (qflist)
map(MODE.normal, "<leader>tQ", "<cmd> Trouble qflist toggle <CR>", { desc = "qflist (Trouble)" })
-- 13: Quickfix List (quickfix)
map(MODE.normal, "<leader>tq", "<cmd> Trouble quickfix toggle <CR>", { desc = "quickfix (Trouble)" })
-- 14: Document symbols (symbols)
map(
  MODE.normal,
  "<leader>tS",
  "<cmd> Trouble symbols toggle focus=false win.position=right <CR>",
  { desc = "symbols (Trouble)" }
)
-- 15: Telescope results previously opened with `require('trouble Sources Telescope') Open()`  (telescope)

---------------------------------------
-- TABUFLINE
---------------------------------------
-- MODE: normal
-- map(MODE.normal, "<leader>X", function()
--   -- require("nvchad.tabufline").closeAllBufs()
--   vim.api.nvim_command "bufdo bd"
--   vim.cmd "NvimTreeFocus"
-- end, { desc = "Close other buffers", noremap = true, silent = true })

local function check_and_save_buffer(bufnr)
  local buf_modified = vim.bo[bufnr].modified
  if buf_modified then
    local choice = vim.fn.confirm(
      "Buffer " .. vim.api.nvim_buf_get_name(bufnr) .. " has unsaved changes. Save?",
      "&Yes\n&No\n&Cancel"
    )
    if choice == 1 then
      -- Save the buffer
      vim.api.nvim_buf_call(bufnr, function()
        vim.cmd "w"
      end)
    elseif choice == 2 then
      -- Discard the changes
      vim.api.nvim_buf_call(bufnr, function()
        vim.cmd "e!"
      end)
    elseif choice == 3 then
      -- Cancel the operation
      return false
    end
  end
  return true
end

map(MODE.normal, "<leader>x", function()
  -- Get the current buffer number
  local bufnr = vim.api.nvim_get_current_buf()
  if check_and_save_buffer(bufnr) then
    vim.api.nvim_buf_delete(bufnr, {})
  end
end, { desc = "Close current buffer", noremap = true, silent = true })
map(MODE.normal, "<leader>X", function()
  -- Iterate over all buffers and close them after checking for unsaved changes
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if not check_and_save_buffer(bufnr) then
      return
    end
    -- Close the buffer
    vim.api.nvim_buf_delete(bufnr, {})
  end
  vim.cmd "NvimTreeFocus"
end, { desc = "Close all buffers", noremap = true, silent = true })

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
map(MODE.normal, "<leader>tt", "<cmd> TodoTrouble <CR>", { desc = "todo (Trouble)", noremap = true, silent = true })
map(MODE.normal, "<leader>ft", "<cmd> TodoTelescope <CR>", { desc = "todo (Telescope)", noremap = true, silent = true })

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
