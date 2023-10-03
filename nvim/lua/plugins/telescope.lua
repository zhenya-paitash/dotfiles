local trouble = require("trouble.providers.telescope")
require("telescope").setup {
  defaults = {
    mappings = {
      i = { ["<c-t>"] = trouble.open_with_trouble },
      n = { ["<c-t>"] = trouble.open_with_trouble },
    },
    file_ignore_patterns = {
      "node_modules",
    }
  },
}

require("telescope").load_extension("notify")

local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader><leader>", telescope_builtin.find_files, {})
vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", telescope_builtin.help_tags, {})
vim.keymap.set("n", "<leader>fn", ":Telescope notify<CR>")
vim.keymap.set("n", "<leader>*", telescope_builtin.grep_string, {})
vim.keymap.set("n", "<leader>gb", telescope_builtin.git_branches, {})
vim.keymap.set("n", "<leader>gc", telescope_builtin.git_commits, {})
vim.keymap.set("n", "<leader>gs", telescope_builtin.git_status, {})
vim.keymap.set("n", "<leader>ls", telescope_builtin.lsp_document_symbols, {})
vim.keymap.set("n", "gr", telescope_builtin.lsp_references, {
  noremap = true,
  silent = true,
})
vim.keymap.set("n", "gd", telescope_builtin.lsp_definitions, {
  noremap = true,
  silent = true,
})
