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

--┌───────────┬─────────────────────────────────────────────────────────────┐
--├ @catecory   CHANGE DEFAULT MAPPINGS
--└───────────┴─────────────────────────────────────────────────────────────┘
-- @ses: https://github.com/NvChad/NvChad/blob/v2.5/lua/nvchad/mappings.lua
--┌─ MODE ───────┐
--│ normal       │
--└──────────────┘
--┌─ MODE ───────┐
--│ terminal     │
--└──────────────┘
map({ "n", "t" }, "<A-t>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal toggleable horizontal term" })

--┌───────────┬─────────────────────────────────────────────────────────────┐
--├ @catecory   GENERAL
--└───────────┴─────────────────────────────────────────────────────────────┘
--┌─ MODE ───────┐
--│ normal       │
--└──────────────┘
-- restore default <C-i> mapping
-- map(MODE.normal, "<C-i>", "<C-i>", { noremap = true, silent = true })
map(MODE.normal, "<Tab>", "<C-i>", { noremap = true, silent = true })
-- map(MODE.normal, "<S-Tab>", "<cmd> bnext <CR>", { noremap = true, silent = true })

map(MODE.normal, "<leader>'", "`", { noremap = true, silent = true })

-- unbind <C-s> [reason: i'm using <C-s> as a leader for TMUX]
map({ MODE.normal, MODE.insert, MODE.visual }, "<C-s>", "", {})

map(MODE.normal, "<leader>a", "ggVGo", { desc = "select all", noremap = true, silent = true })
-- map(MODE.normal, "<leader>z", "zfS", { desc = "create folder from ...", noremap = true, silent = true })
-- map(MODE.normal, "n", function()
--   vim.cmd "normal! n"
--   vim.cmd "normal! zz"
-- end, { desc = "prev search", noremap = true, silent = true })
-- map(MODE.normal, "N", function()
--   vim.cmd "normal! N"
--   vim.cmd "normal! zz"
-- end, { desc = "next search", noremap = true, silent = true })
map(MODE.normal, "<F1>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { desc = "Show signature help" })
map(MODE.normal, "<leader>w", "<cmd> w <CR>", { desc = "save current file", noremap = true, silent = true })
-- RESIZE PANELS
map(MODE.normal, "<A-right>", "<cmd> :vertical resize +10 <CR>", { desc = "resize right", noremap = true, silent = true })
map(MODE.normal, "<A-left>", "<cmd> vertical resize -10 <CR>", { desc = "resize left", noremap = true, silent = true })
map(MODE.normal, "<A-up>", "<cmd> resize +10% <CR>", { desc = "resize up", noremap = true, silent = true })
map(MODE.normal, "<A-down>", "<cmd> resize -10% <CR>", { desc = "resize down", noremap = true, silent = true })
map(MODE.normal, "<C-w>l", "<cmd> vertical resize +15 <CR>", { desc = "resize right", noremap = true, silent = true })
map(MODE.normal, "<C-w>h", "<cmd> vertical resize -15 <CR>", { desc = "resize left", noremap = true, silent = true })
map(MODE.normal, "<C-w>k", "<cmd> resize +15% <CR>", { desc = "resize up", noremap = true, silent = true })
map(MODE.normal, "<C-w>j", "<cmd> resize -15% <CR>", { desc = "resize down", noremap = true, silent = true })
-- TABS
map(MODE.normal, "<leader>tc", "<cmd> tabnew <CR>", { desc = "tab new", noremap = true, silent = true })
map(MODE.normal, "<leader>tx", "<cmd> tabclose <CR>", { desc = "tab close", noremap = true, silent = true })
map(MODE.normal, "<leader>tn", "<cmd> tabn <CR>", { desc = "tab next", noremap = true, silent = true })
map(MODE.normal, "<leader>tp", "<cmd> tabp <CR>", { desc = "tab prev", noremap = true, silent = true })
-- return cursor position after `paste`
map(MODE.normal, "<p>", function()
  local row, col = table.unpack(vim.api.nvim_win_get_cursor(0))
  vim.cmd "put"
  vim.api.nvim_win_set_cursor(0, { row, col })
end, { noremap = true, silent = true })

-- MODE: visual
map(MODE.visual, ">", ">gv", { desc = "indent left", noremap = true, silent = true })
map(MODE.visual, "<", "<gv", { desc = "indent right", noremap = true, silent = true })
map(MODE.visual, "<leader>y", '"+y', { desc = "copy system", noremap = true, silent = true })
map(MODE.visual, "<C-c>", '"+y gv-gv', { desc = "copy system", noremap = true, silent = true })
map(MODE.visual, 'y', 'ygv<esc>', { noremap = true, silent = true })

--┌─ MODE ───────┐
--│ insert       │
--└──────────────┘
-- map(MODE.insert, "<C-c>", '"+y', { desc = "Copy sys", noremap = true, silent = true })
-- map(MODE.insert, "<C-j>", "<ESC> <cmd> m .+1 <CR> == gi", { desc = "Move line up", noremap = true, silent = true })
-- map(MODE.insert, "<C-k>", "<ESC> <cmd> m .-2 <CR> == gi", { desc = "Move line down", noremap = true, silent = true })
map(MODE.insert, "<F1>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { desc = "help signature" })

--┌─ MODE ───────┐
--│ visual_block │
--└──────────────┘
-- MODE: visual_block
map(MODE.visual_block, "J", ":m '>+1 <CR> gv-gv", { desc = "block move down", noremap = true, silent = true })
map(MODE.visual_block, "K", ":m '<-2 <cr> gv-gv", { desc = "block move up", noremap = true, silent = true })
-- map(MODE.visual_block, "<C-c>", "'+y gv", { desc = "Copy sys", noremap = true, silent = true })

--┌───────────┬─────────────────────────────────────────────────────────────┐
--├ @catecory   TELESCOPE
--└───────────┴─────────────────────────────────────────────────────────────┘
--┌─ MODE ───────┐
--│ normal       │
--└──────────────┘
map(MODE.normal, "<leader><leader>", "<cmd> Telescope find_files <CR>", { desc = "find files (Telescope)" })
map(MODE.normal, "<leader>fs", "<cmd> Telescope lsp_document_symbols <CR>", { desc = "document symbols (Telescope)" })
map(MODE.normal, "<leader>fr", "<cmd> Telescope resume <CR>", { desc = "resume last search (Telescope)" })
map(MODE.normal, "<leader>gb", "<cmd> Telescope git_branches <CR>", { desc = "git branch (Telescope)" })
map(MODE.normal, "<leader>*", "<cmd> Telescope grep_string <CR>", { desc = "grep string (Telescope)" })
map(MODE.normal, "<leader>gr", "<cmd> Telescope lsp_references <CR>", { desc = "find references (Telescope)" })
map(MODE.normal, "<leader>gd", "<cmd> Telescope lsp_definitions <CR>", { desc = "find definitions (Telescope)" })
map(MODE.normal, '<leader>f"', "<cmd> Telescope registers <CR>", { desc = "find registers (Telescope)" })
map(MODE.normal, "<leader>f'", "<cmd> Telescope marks <CR>", { desc = "find marks (Telescope)" })
map(MODE.normal, "<leader>fk", "<cmd> Telescope keymaps <CR>", { desc = "find keymaps (Telescope)" })
map(MODE.normal, "<leader>fn", "<cmd> Telescope noice <CR>", { desc = "find noice (Telescope | Noice)" })
map(MODE.normal, "<leader>fy", "<cmd> Telescope yank_history <CR>", { desc = "find yanks (Telescope | Yanky)" })
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
      buf_map("i", "<C-d>", actions.delete_buffer)
      return true
    end,
  }
end, { desc = "buffers (Telescope)" })

--┌─ MODE ───────┐
--│ visual       │
--└──────────────┘
map(MODE.visual, "<leader>*", "<cmd> Telescope grep_string <CR>", { desc = "grep string (Telescope)" })

--┌───────────┬─────────────────────────────────────────────────────────────┐
--├ @catecory   TROUBLE
--└───────────┴─────────────────────────────────────────────────────────────┘
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

--┌─ MODE ───────┐
--│ normal       │
--└──────────────┘
map(MODE.normal, "]t", "<cmd> lua require('trouble').next { skip_groups = true, jump = true } <CR>", { desc = "go to next (Trouble)" })
map(MODE.normal, "[t", "<cmd> lua require('trouble').prev { skip_groups = true, jump = true } <CR>", { desc = "go to previous (Trouble)" })
-- map(MODE.normal, "<leader>t", "<cmd> Trouble <CR>", { desc = "Trouble" })
map(MODE.normal, "<leader>td", "<cmd> Trouble diagnostics toggle <CR>", { desc = "diagnostics (Trouble)" })
map(MODE.normal, "<leader>tD", "<cmd> Trouble diagnostics toggle filter.buf=0 <CR>", { desc = "diagnostics buffer (Trouble)" })
map(MODE.normal, "<leader>tl", "<cmd> Trouble loclist toggle <CR>", { desc = "loclist (Trouble)" })
map(MODE.normal, "<leader>tl", "<cmd> Trouble lsp toggle focus=false win.position=right <CR>", { desc = "lsp def/ref/... (Trouble)" })
map(MODE.normal, "<leader>ts", "<cmd> Trouble lsp_document_symbols toggle focus=false win.position=right <CR>", { desc = "lps symbols (Trouble)" })
map(MODE.normal, "<leader>tQ", "<cmd> Trouble qflist toggle <CR>", { desc = "qflist (Trouble)" })
map(MODE.normal, "<leader>tq", "<cmd> Trouble quickfix toggle <CR>", { desc = "quickfix (Trouble)" })
map(MODE.normal, "<leader>tS", "<cmd> Trouble symbols toggle focus=false win.position=right <CR>", { desc = "symbols (Trouble)" })

--┌───────────┬─────────────────────────────────────────────────────────────┐
--├ @catecory   TABUFLINE
--└───────────┴─────────────────────────────────────────────────────────────┘
--┌─ MODE ───────┐
--│ normal       │
--└──────────────┘
-- map(MODE.normal, "<leader>X", function()
--   require("nvchad.tabufline").closeAllBufs()
--   vim.cmd "NvimTreeFocus"
-- end, { desc = "Close other buffers", noremap = true, silent = true })

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

--┌───────────┬─────────────────────────────────────────────────────────────┐
--├ @catecory   FLASH
--└───────────┴─────────────────────────────────────────────────────────────┘
--┌─ MODE ───────┐
--│ normal       │
--└──────────────┘
-- INFO: this keybindings is here "./plugins/setup/flash.lua"
-- map({ MODE.normal, MODE.visual_block, MODE.operator }, "<leader>s", function()
--   require("flash").jump()
-- end, { desc = "Flash", noremap = true, silent = true })
-- map({ MODE.normal, MODE.visual_block, MODE.operator }, "<leader>S", function()
--   require("flash").treesitter()
-- end, { desc = "Flash Treesitter", noremap = true, silent = true })

--┌───────────┬─────────────────────────────────────────────────────────────┐
--├ @catecory   TODOCOMMENTS
--└───────────┴─────────────────────────────────────────────────────────────┘
--┌─ MODE ───────┐
--│ normal       │
--└──────────────┘
map(MODE.normal, "<leader>tt", "<cmd> TodoTrouble <CR>", { desc = "todo (Trouble)", noremap = true, silent = true })
map(MODE.normal, "<leader>ft", "<cmd> TodoTelescope <CR>", { desc = "todo (Telescope)", noremap = true, silent = true })

--┌───────────┬─────────────────────────────────────────────────────────────┐
--├ @catecory   LAZYGIT
--└───────────┴─────────────────────────────────────────────────────────────┘
--┌─ MODE ───────┐
--│ normal       │
--└──────────────┘
-- map(MODE.normal, "<leader>gl", "<cmd> LazyGit <CR>", { desc = "LazyGit" })

--┌───────────┬─────────────────────────────────────────────────────────────┐
--├ @catecory   DAP
--└───────────┴─────────────────────────────────────────────────────────────┘
--┌─ MODE ───────┐
--│ normal       │
--└──────────────┘
map(MODE.normal, "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<CR>", { desc = "breakpoint (Debugger)" })
map(MODE.normal, "<leader>dB", "<cmd>lua require('dap').clear_breakpoints()<CR>", { desc = "breakpoint clear all (Debugger)" })
map(MODE.normal, "<leader>dt", "<cmd>lua require('dap').repl.toggle()<CR>", { desc = "terminal (Debugger)" })
-- map(MODE.normal, "<leader>ds", "<cmd>lua require('dap').continue()<CR>", { desc = "start (Debugger)" })
map(MODE.normal, "<leader>ds", "<cmd>lua require('plugins.setup._custom.debugger_telescope_selector').pick_debugger() <CR>", { desc = "start (Debugger)" })
map(MODE.normal, "<leader>dp", "<cmd>lua require('plugins.setup._custom.debugger_telescope_selector').pick_process() <CR>", { desc = "start (Debugger)" })
map(MODE.normal, "<leader>dS", "<cmd>lua require('dap').pause()<CR>", { desc = "pause (Debugger)" })
map(MODE.normal, "<leader>dr", "<cmd>lua require('dap').restart_frame()<CR>", { desc = "restart (Debugger)" })
map(MODE.normal, "<leader>dx", "<cmd>lua require('dap').close()<CR>", { desc = "close (Debugger)" })
map(MODE.normal, "<leader>dX", "<cmd>lua require('dap').terminate()<CR>", { desc = "terminate (Debugger)" })
map(MODE.normal, "<leader>d.", "<cmd>lua require('dap').step_into()<CR>", { desc = "step into (Debugger)" })
map(MODE.normal, "<leader>d,", "<cmd>lua require('dap').step_over()<CR>", { desc = "step over (Debugger)" })
map(MODE.normal, "<leader>dn", "<cmd>lua require('dap').step_out()<CR>", { desc = "step out (Debugger)" })
map(MODE.normal, "<leader>dc", "<cmd>lua require('dap').run_to_cursor()<CR>", { desc = "run to cursor (Debugger)" })

--┌───────────┬─────────────────────────────────────────────────────────────┐
--├ @catecory   DAP UI
--└───────────┴─────────────────────────────────────────────────────────────┘
--┌─ MODE ───────┐
--│ normal       │
--└──────────────┘
map(MODE.normal, "<leader>du", "<cmd>lua require('dapui').toggle() <CR>", { desc = "UI toggle (Dap UI)" })
map(MODE.normal, "<leader>dk", function()
  vim.ui.input({ prompt = "Expression: " }, function(expr)
    if expr then
      require("dapui").eval(expr, { enter = true })
    end
  end)
end, { desc = "evaluate input (Dap UI)", noremap = true, silent = true })
-- maps.n["<leader>dh"] = { function() require("dap.ui.widgets").hover() end, desc = "Debugger Hover" }
map(MODE.normal, "<leader>dK", "<cmd>lua require('dap.ui.widgets').hover() <CR>", { desc = "hover (Dap UI)" })

--┌─ MODE ───────┐
--│ visual       │
--└──────────────┘
map(MODE.visual, "<leader>dk", "<cmd>lua require('dapui').eval()<CR>", { desc = "evaluate input (Dau UI)" })

--┌───────────┬─────────────────────────────────────────────────────────────┐
--├ @catecory   PERSISTENCE
--└───────────┴─────────────────────────────────────────────────────────────┘
--┌─ MODE ───────┐
--│ normal       │
--└──────────────┘
map(MODE.normal, "<leader>qs", function()
  require("persistence").load()
  vim.notify_once("  session loaded!", vim.log.levels.INFO, { title = "Persistence" })
end, { desc = "load (Persistence)" })
map(MODE.normal, "<leader>ql", function()
  require("persistence").load { last = true }
  vim.notify_once("  session loaded! (last session)", vim.log.levels.INFO, { title = "Persistence" })
end, { desc = "load last (Persistence)" })
map(MODE.normal, "<leader>qd", function()
  require("persistence").stop()
  vim.notify_once("󱙄 session won't be saved!", vim.log.levels.WARN, { title = "Persistence" })
end, { desc = "don't save (Persistence)" })

--┌───────────┬─────────────────────────────────────────────────────────────┐
--├ @catecory   DIFFVIEW
--└───────────┴─────────────────────────────────────────────────────────────┘
--┌─ MODE ───────┐
--│ normal       │
--└──────────────┘
map(MODE.normal, "<leader>gd", "<cmd> DiffviewOpen <CR>", { desc = "git open (Diffview)" })
map(MODE.normal, "<leader>gc", "<cmd> DiffviewClose <CR>", { desc = "git close (Diffview)" })

--┌───────────┬─────────────────────────────────────────────────────────────┐
--├ @catecory   MARKDOWN PREVIEW
--└───────────┴─────────────────────────────────────────────────────────────┘
--┌─ MODE ───────┐
--│ normal       │
--└──────────────┘
map(MODE.normal, "<leader>po", function()
  vim.cmd "MarkdownPreviewToggle"
  print " markdown preview current file enabled!"
end, { desc = ".md preview (Markdown Preview)" })
-- map(MODE.normal, "<leader>mpc", "<cmd> MarkdownPreview <CR>", { desc = "create (Markdown Preview)" })
-- map(MODE.normal, "<leader>mpx", "<cmd> MarkdownPreviewStop <CR>", { desc = "close (Markdown Preview)" })
map(MODE.normal, "<leader>pm", "<cmd> Markview toggle <CR>", { desc = "markdown preview toggle (Markview)" })

--┌───────────┬─────────────────────────────────────────────────────────────┐
--├ @catecory   JSON
--└───────────┴─────────────────────────────────────────────────────────────┘
map(MODE.normal, "<leader>pj", ":%!jq '.'<CR>")

--┌───────────┬─────────────────────────────────────────────────────────────┐
--├ @catecory   REST.NVIM
--└───────────┴─────────────────────────────────────────────────────────────┘
-- map(MODE.normal, "<leader>rr", "<cmd> Rest run <CR>", { desc = "run request under the cursor (Rest)" })
-- map(MODE.normal, "<leader>rl", "<cmd> Rest run last <CR>", { desc = "run last request (Rest)" })
-- map(MODE.normal, "<leader>re", "<cmd> Telescope rest select_env <CR>", { desc = "select env (Rest)" })

--┌───────────┬─────────────────────────────────────────────────────────────┐
--├ @catecory   GRUG-FAR.NVIM
--└───────────┴─────────────────────────────────────────────────────────────┘
map(MODE.normal, "<leader>fg", "<cmd> lua require('grug-far').open() <CR>", { desc = "search & replace (Grug)" })
map(
  MODE.normal,
  "<leader>f*",
  "<cmd> lua require('grug-far').open({ prefills = { search = vim.fn.expand('<cword>') } }) <CR>",
  { desc = "search & replace under cursor (Grug)" }
)

--┌───────────┬─────────────────────────────────────────────────────────────┐
--├ @catecory   UI
--└───────────┴─────────────────────────────────────────────────────────────┘
-- MODE: normal
map(MODE.normal, "<leader>n", "<cmd> NoiceAll <CR>", { desc = "messages (Noice)" })

--┌───────────┬─────────────────────────────────────────────────────────────┐
--├ @catecory   HTTP CLIENT `kulala`
--└───────────┴─────────────────────────────────────────────────────────────┘
map(MODE.normal, "<leader>rr", "<cmd>lua require('kulala').run()<cr>", { desc = "Execute current request" })

--┌───────────┬─────────────────────────────────────────────────────────────┐
--├ @catecory   OIL.NVIM
--└───────────┴─────────────────────────────────────────────────────────────┘
map(MODE.normal, "<leader>-", "<cmd>lua require('oil').toggle_float()<cr>", { desc = "buffer file explorer (Oil.nvim)" })

--┌───────────┬─────────────────────────────────────────────────────────────┐
--├ @catecory   SHOWKEYS
--└───────────┴─────────────────────────────────────────────────────────────┘
map(MODE.normal, "<leader>pk", "<cmd> ShowkeysToggle <CR>", { desc = "show keys toggle (showkeys)" })

--┌───────────┬─────────────────────────────────────────────────────────────┐
--├ @catecory   TIMERLY
--└───────────┴─────────────────────────────────────────────────────────────┘
-- map(MODE.normal, "<leader>pt", "<cmd> TimerlyToggle <CR>", { desc = "timer toggle (Timerly)" })

--┌───────────┬─────────────────────────────────────────────────────────────┐
--├ @catecory   HARDTIME
--└───────────┴─────────────────────────────────────────────────────────────┘
map(MODE.normal, "<leader>ph", "<cmd> Hardtime toggle<cr>", { desc = "ON/OFF best practice (Hardtime)" })
map(MODE.normal, "<leader>pht", "<cmd> Hardtime toggle<cr>", { desc = "TOGGLE best practice (Hardtime)" })
map(MODE.normal, "<leader>phe", "<cmd> Hardtime enable<cr>", { desc = "ON best practice (Hardtime)" })
map(MODE.normal, "<leader>phd", "<cmd> Hardtime disable<cr>", { desc = "OFF best practice (Hardtime)" })
map(MODE.normal, "<leader>phr", "<cmd> Hardtime report<cr>", { desc = "show report (Hardtime)" })

--┌───────────┬─────────────────────────────────────────────────────────────┐
--├ @catecory   BARBECUE
--└───────────┴─────────────────────────────────────────────────────────────┘
map(MODE.normal, "<leader>pb", "<cmd> Barbecue toggle <CR>", { desc = "winbar toggle (Barbecue)" })

--┌───────────┬─────────────────────────────────────────────────────────────┐
--├ @catecory   HARPOON
--└───────────┴─────────────────────────────────────────────────────────────┘
-- map( MODE.normal, "<leader>hl", "<cmd> lua require('harpoon.ui').toggle_quick_menu() <CR>", { desc = "show list (Harpoon)" })
-- map(MODE.normal, "<leader>ha", "<cmd> lua require('harpoon.mark').add_file() <CR>", { desc = "ADD file (Harpoon)" })
-- map(MODE.normal, "<leader>hn", "<cmd> lua require('harpoon.ui').nav_next() <CR>", { desc = "NEXT file (Harpoon)" })
-- map(MODE.normal, "<leader>hp", "<cmd> lua require('harpoon.ui').nav_prev() <CR>", { desc = "PREV file (Harpoon)" })
-- map(MODE.normal, "<leader>hf", "<cmd> Telescope harpoon marks <CR>", { desc = "find harpoon marks (Telescope | Harpoon)" })

--┌───────────┬─────────────────────────────────────────────────────────────┐
--├ @catecory   DROPBAR.NVIM
--└───────────┴─────────────────────────────────────────────────────────────┘
map(MODE.normal, "<leader>pd", "<cmd> lua require('dropbar.api').pick() <CR>", { desc = "pick dropbar (Dropbar)" })

--┌───────────┬─────────────────────────────────────────────────────────────┐
--├ @catecory   FZF
--└───────────┴─────────────────────────────────────────────────────────────┘
map(MODE.normal, "<leader>fe", "<cmd> CustomFzf <CR>", { desc = "find all files (fzf)" })

--┌───────────┬─────────────────────────────────────────────────────────────┐
--├ @catecory   SNACKS
--└───────────┴─────────────────────────────────────────────────────────────┘
local Snacks = require "snacks"
--┌─ MODE ───────┐
--│ normal       │
--└──────────────┘
map(MODE.normal, "<leader>pu", function()
  Snacks.notifier.hide()
end, { desc = "Clear notifications" })
map(MODE.normal, "<leader>x", function()
  Snacks.bufdelete()
end, { desc = "Close buffer" })
map(MODE.normal, "<leader>X", function()
  Snacks.bufdelete.all()
end, { desc = "Close all buffer" })
map(MODE.normal, "<leader>gb", function()
  Snacks.git.blame_line()
end, { desc = "Git Blame Line" })
map(MODE.normal, "<leader>gB", function()
  Snacks.gitbrowse()
end, { desc = "Git Browse" })
map(MODE.normal, "<leader>[", function()
  Snacks.words.jump(vim.v.count1)
end, { desc = "Next Reference" })
map(MODE.normal, "<leader>]", function()
  Snacks.words.jump(-vim.v.count1)
end, { desc = "Prev Reference" })
-- map(MODE.normal, "<A-h>", function() Snacks.terminal() end, { desc = "Terminal" })
map(MODE.normal, "<leader>lg", function()
  Snacks.lazygit()
end, { desc = "Open Lazygit" })
map(MODE.normal, "<leader>lf", function()
  Snacks.lazygit.log_file()
end, { desc = "file history (Lazygit)" })
map(MODE.normal, "<leader>ll", function()
  Snacks.lazygit.log()
end, { desc = "log (Lazygit)" })

--┌───────────┬─────────────────────────────────────────────────────────────┐
--├ @catecory   TREE.WALKER
--└───────────┴─────────────────────────────────────────────────────────────┘
--┌─ MODE ───────┐
--│ normal       │
--└──────────────┘
map(MODE.normal, "<M-j>", "<cmd>Treewalker Down<CR>", { desc = "  down (Treewalker)" })
map(MODE.normal, "<M-k>", "<cmd>Treewalker Up<CR>", { desc = "  up (Treewalker)" })
map(MODE.normal, "<M-h>", "<cmd>Treewalker Left<CR>", { desc = "  left (Treewalker)" })
map(MODE.normal, "<M-l>", "<cmd>Treewalker Right<CR>", { desc = "  right (Treewalker)" })
--┌─ MODE ───────┐
--│ visual       │
--└──────────────┘
map(MODE.visual, "<M-j>", "<cmd>Treewalker Down<CR>", { desc = "  down (Treewalker)" })
map(MODE.visual, "<M-k>", "<cmd>Treewalker Up<CR>", { desc = "  up (Treewalker)" })
map(MODE.visual, "<M-h>", "<cmd>Treewalker Left<CR>", { desc = "  left (Treewalker)" })
map(MODE.visual, "<M-l>", "<cmd>Treewalker Right<CR>", { desc = "  right (Treewalker)" })

--┌───────────┬─────────────────────────────────────────────────────────────┐
--├ @catecory   DOOING
--└───────────┴─────────────────────────────────────────────────────────────┘
--┌─ MODE ───────┐
--│ normal       │
--└──────────────┘
-- map(MODE.normal, "<leader>pt", "<cmd> Dooing <CR>", { desc = "todo open (Dooing)" })

--┌───────────┬─────────────────────────────────────────────────────────────┐
--├ @catecory   AUGMENT
--└───────────┴─────────────────────────────────────────────────────────────┘
--┌─ MODE ───────┐
--│ normal       │
--└──────────────┘
map(MODE.normal, "<leader>au", "<cmd>:Augment chat <CR>", { desc = "ai chat (Augment)" })
map(MODE.normal, "<leader>aut", "<cmd>:Augment chat-toggle <CR>", { desc = "ai chat toggle (Augment)" })
map(MODE.normal, "<leader>aus", "<cmd>:Augment status <CR>", { desc = "ai status (Augment)" })
map(MODE.normal, "<leader>aua", "<cmd>:Augment signin <CR>", { desc = "ai login (Augment)" })
map(MODE.normal, "<leader>aul", "<cmd>:Augment log <CR>", { desc = "ai logs (Augment)" })
