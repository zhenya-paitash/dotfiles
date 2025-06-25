local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities
-- local capabilities = require('blink.cmp').get_lsp_capabilities()

local lspconfig = require "lspconfig"

local servers = {
  "html",
  "cssls",
  -- "bashls", -- bash-language-server
  -- "tsserver",  -- TODO: switch from this
  "ts_ls",
  -- "clangd",
  -- "prismals",
  "tailwindcss",
  "gopls",
  "templ",
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- typescript
lspconfig.ts_ls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}
-- lspconfig.tsserver.setup {
--   on_attach = on_attach,
--   on_init = on_init,
--   capabilities = capabilities,
-- }

-- go
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

-- tailwindcss
lspconfig.tailwindcss.setup {
  filetypes = {
    "html",
    "javascriptreact",
    "typescriptreact",
  },
}

-- go/templ
lspconfig.templ.setup {
  cmd = { "templ", "lsp", "-http=localhost:7474", "-log=~/templ/templ.log" },
  filetypes = { "templ" },
  root_dir = require("lspconfig/util").root_pattern("go.mod", ".git"),
  settings = {},
}
