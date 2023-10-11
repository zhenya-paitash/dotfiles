require("mason").setup()
require("mason-lspconfig").setup {
  automatic_installation = true,
  ensure_installed = {
    "lua_ls",
    "tsserver",
    "html",
    "cssls",
    "tailwindcss",
    -- "prismals",
    -- "eslint",
  },
}
