local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = {
  "html",
  "cssls",
  "tsserver",
  "clangd",
  "prismals",
  "tailwindcss",
  "gopls",
  "templ",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- CUSTOM CONFIGURATION
-- Настройка gopls
lspconfig.gopls.setup {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gosum", "gowork", "gotmpl", "gotempl", "templ" },
  root_dir = require("lspconfig/util").root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },

  on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    local opts = { noremap = true, silent = true }
    buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "<leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap("n", "<leader>ra", "<Cmd>lua require('nvchad.renamer').open()<CR>", opts)
  end,
}

lspconfig.tailwindcss.setup {
  filetypes = {
    "html",
    "javascriptreact",
    "typescriptreact",
  },
}

lspconfig.templ.setup {
  cmd = { "templ", "lsp", "-http=localhost:7474", "-log=~/templ/templ.log" },
  filetypes = { "templ" },
  root_dir = require("lspconfig/util").root_pattern("go.mod", ".git"),
  settings = {},
}
