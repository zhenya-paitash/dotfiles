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
-- map(MODE.normal, "<S-Tab>", "<cmd> bnext <CR>", { noremap = true, silent = true })

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
-- RESIZE PANELS
map(
  MODE.normal,
  "<A-right>",
  "<cmd> :vertical resize +10 <CR>",
  { desc = "Resize right", noremap = true, silent = true }
)
map(MODE.normal, "<A-left>", "<cmd> vertical resize -10 <CR>", { desc = "Resize left", noremap = true, silent = true })
map(MODE.normal, "<A-up>", "<cmd> resize +10% <CR>", { desc = "Resize up", noremap = true, silent = true })
map(MODE.normal, "<A-down>", "<cmd> resize -10% <CR>", { desc = "Resize down", noremap = true, silent = true })
map(MODE.normal, "<C-w>l", "<cmd> vertical resize +15 <CR>", { desc = "Resize right", noremap = true, silent = true })
map(MODE.normal, "<C-w>h", "<cmd> vertical resize -15 <CR>", { desc = "Resize left", noremap = true, silent = true })
map(MODE.normal, "<C-w>k", "<cmd> resize +15% <CR>", { desc = "Resize up", noremap = true, silent = true })
map(MODE.normal, "<C-w>j", "<cmd> resize -15% <CR>", { desc = "Resize down", noremap = true, silent = true })
-- TABS
map(MODE.normal, "<leader>tn", "<cmd> tabnew <CR>", { desc = "New tab", noremap = true, silent = true })
map(MODE.normal, "<leader>tc", "<cmd> tabclose <CR>", { desc = "Close tab", noremap = true, silent = true })
map(MODE.normal, "<leader>t>", "<cmd> tabn <CR>", { desc = "Next tab", noremap = true, silent = true })
map(MODE.normal, "<leader>t<", "<cmd> tabp <CR>", { desc = "Prev tab", noremap = true, silent = true })

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
map(MODE.normal, "<leader>fr", "<cmd> Telescope resume <CR>", { desc = "resume last search (Telescope)" })
map(MODE.normal, "<leader>gb", "<cmd> Telescope git_branches <CR>", { desc = "git branch (Telescope)" })
map(MODE.normal, "<leader>*", "<cmd> Telescope grep_string <CR>", { desc = "grep string (Telescope)" })
map(MODE.normal, "<leader>gr", "<cmd> Telescope lsp_references <CR>", { desc = "find references (Telescope)" })
map(MODE.normal, "<leader>gd", "<cmd> Telescope lsp_definitions <CR>", { desc = "find definitions (Telescope)" })
map(MODE.normal, "<leader><Tab>", function()
  local actions = require "telescope.actions"

  require("telescope.builtin").buffers {
    prompt_title = "Buffers",
    previewer = false,
    sorter = require("telescope.config").values.generic_sorter {},
    layout_config = { width = 0.3, height = 0.25 },
    sort_lastused = true,
    ignore_current_buffer = true,
    attach_mappings = function(prompt_bufnr, buf_map)
      buf_map("i", "<esc>", actions.close)
      buf_map("i", "<Tab>", actions.move_selection_next)
      buf_map("i", "<S-Tab>", actions.move_selection_previous)
      buf_map("n", "<Tab>", actions.move_selection_next)
      buf_map("n", "<S-Tab>", actions.move_selection_previous)
      buf_map("i", "<C-d>", actions.delete_buffer)
      return true
    end,
  }
end, { desc = "buffers (Telescope)" })
-- TODO: next map is auto choice if you have only 1 option after search in telescope
-- map(MODE.normal, "<leader><tab>", function()
--   local actions = require "telescope.actions"
--   local action_state = require "telescope.actions.state"
--   local action_set = require "telescope.actions.set"
--
--   require("telescope.builtin").buffers {
--     prompt_title = "buffers",
--     previewer = false,
--     sorter = require("telescope.config").values.generic_sorter {},
--     layout_config = { width = 0.3, height = 0.25 },
--     sort_lastused = true,
--     ignore_current_buffer = true, -- пропускаем текущий буфер
--     attach_mappings = function(prompt_bufnr, buf_map)
--       local function check_for_single_result()
--         local picker = action_state.get_current_picker(prompt_bufnr)
--         local num_results = picker.manager:num_results()
--
--         if num_results == 1 then
--           action_set.select(prompt_bufnr, "default")
--         end
--       end
--
--       buf_map("i", "<esc>", actions.close)
--       buf_map("i", "<tab>", actions.move_selection_next)
--       buf_map("i", "<s-tab>", actions.move_selection_previous)
--       buf_map("n", "<tab>", actions.move_selection_next)
--       buf_map("n", "<s-tab>", actions.move_selection_previous)
--       buf_map("i", "<c-d>", actions.delete_buffer)
--
--       -- register an event to check results count on every complete search
--       local picker = action_state.get_current_picker(prompt_bufnr)
--       picker:register_completion_callback(check_for_single_result)
--
--       return true
--     end,
--   }
-- end, { desc = "buffers (telescope)" })

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
map(
  MODE.normal,
  "]t",
  "<cmd> lua require('trouble').next { skip_groups = true, jump = true } <CR>",
  { desc = "go to next (Trouble)" }
)
map(
  MODE.normal,
  "[t",
  "<cmd> lua require('trouble').prev { skip_groups = true, jump = true } <CR>",
  { desc = "go to previous (Trouble)" }
)
map(MODE.normal, "<leader>t", "<cmd> Trouble <CR>", { desc = "Trouble" })
map(MODE.normal, "<leader>td", "<cmd> Trouble diagnostics toggle <CR>", { desc = "diagnostics (Trouble)" })
map(
  MODE.normal,
  "<leader>tD",
  "<cmd> Trouble diagnostics toggle filter.buf=0 <CR>",
  { desc = "diagnostics buffer (Trouble)" }
)
map(MODE.normal, "<leader>tl", "<cmd> Trouble loclist toggle <CR>", { desc = "loclist (Trouble)" })
map(
  MODE.normal,
  "<leader>tl",
  "<cmd> Trouble lsp toggle focus=false win.position=right <CR>",
  { desc = "lsp def/ref/... (Trouble)" }
)
map(
  MODE.normal,
  "<leader>ts",
  "<cmd> Trouble lsp_document_symbols toggle focus=false win.position=right <CR>",
  { desc = "lps symbols (Trouble)" }
)
map(MODE.normal, "<leader>tQ", "<cmd> Trouble qflist toggle <CR>", { desc = "qflist (Trouble)" })
map(MODE.normal, "<leader>tq", "<cmd> Trouble quickfix toggle <CR>", { desc = "quickfix (Trouble)" })
map(
  MODE.normal,
  "<leader>tS",
  "<cmd> Trouble symbols toggle focus=false win.position=right <CR>",
  { desc = "symbols (Trouble)" }
)

---------------------------------------
-- TABUFLINE
---------------------------------------
-- MODE: normal
map(MODE.normal, "<leader>X", function()
  require("nvchad.tabufline").closeAllBufs()
  -- vim.api.nvim_command "bufdo bd"
  vim.cmd "NvimTreeFocus"
end, { desc = "Close other buffers", noremap = true, silent = true })

-- local function check_and_save_buffer(bufnr)
--   local buf_modified = vim.bo[bufnr].modified
--   if buf_modified then
--     local choice = vim.fn.confirm(
--       "Buffer " .. vim.api.nvim_buf_get_name(bufnr) .. " has unsaved changes. Save?",
--       "&Yes\n&No\n&Cancel"
--     )
--     if choice == 1 then
--       -- Save the buffer
--       vim.api.nvim_buf_call(bufnr, function()
--         vim.cmd "w"
--       end)
--     elseif choice == 2 then
--       -- Discard the changes
--       vim.api.nvim_buf_call(bufnr, function()
--         vim.cmd "e!"
--       end)
--     elseif choice == 3 then
--       -- Cancel the operation
--       return false
--     end
--   end
--   return true
-- end
--
-- map(MODE.normal, "<leader>x", function()
--   -- Get the current buffer number
--   local bufnr = vim.api.nvim_get_current_buf()
--   if check_and_save_buffer(bufnr) then
--     vim.api.nvim_buf_delete(bufnr, {})
--   end
-- end, { desc = "Close current buffer", noremap = true, silent = true })
-- map(MODE.normal, "<leader>X", function()
--   -- Iterate over all buffers and close them after checking for unsaved changes
--   for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
--     if not check_and_save_buffer(bufnr) then
--       return
--     end
--     -- Close the buffer
--     vim.api.nvim_buf_delete(bufnr, {})
--   end
--   vim.cmd "NvimTreeFocus"
-- end, { desc = "Close all buffers", noremap = true, silent = true })

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
map(MODE.normal, "<leader>gd", "<cmd> DiffviewOpen <CR>", { desc = "git Diffview Open" })
map(MODE.normal, "<leader>gc", "<cmd> DiffviewClose <CR>", { desc = "git Diffview Close" })

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
map(MODE.normal, "<leader>rr", "<cmd> Rest run <CR>", { desc = "run request under the cursor (Rest)" })
map(MODE.normal, "<leader>rl", "<cmd> Rest run last <CR>", { desc = "run last request (Rest)" })
map(MODE.normal, "<leader>re", "<cmd> Telescope rest select_env <CR>", { desc = "select env (Rest)" })

---------------------------------------
-- GRUG-FAR.NVIM
---------------------------------------
map(MODE.normal, "<leader>fg", "<cmd> lua require('grug-far').grug_far() <CR>", { desc = "search & replace (Grug)" })
map(
  MODE.normal,
  "<leader>f*",
  "<cmd> lua require('grug-far').grug_far({ prefills = { search = vim.fn.expand('<cword>') } }) <CR>",
  { desc = "search & replace under cursor (Grug)" }
)
