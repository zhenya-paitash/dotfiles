local null_ls = require "null-ls"

local b = null_ls.builtins

local sources = {
  -- FORMATTERS
  -- lua
  b.formatting.stylua,

  -- js/ts
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!

  -- golang
  b.formatting.gofmt,
  -- b.formatting.goimports,
  -- b.formatting.gofumpt,
  -- b.diagnostics.golint,
  -- b.diagnostics.govet,
  -- b.diagnostics.gosec,

  -- LINTERS
  -- pprettier
  b.formatting.prettierd.with {
    filetypes = {
      "html",
      "markdown",
      "css",

      "scss",
      "less",
      "json",
      "jsonc",
      "yaml",
      "markdown.mdx",
      "graphql",
      "handlebars",
    },
  },

  -- eslint
  -- FIX: eslint_d starts a new instance each time it is called
  -- link: https://github.com/mantoni/eslint_d.js/issues/264
  -- b.diagnostics.eslint_d,
  -- b.formatting.eslint_d.with {
  --   filetypes = {
  --     "javascript",
  --     "typescript",
  --     "javascriptreact",
  --     "typescriptreact",
  --   }
  -- },
}

null_ls.setup {
  debug = true,
  sources = sources,
}
