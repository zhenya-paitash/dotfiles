local null_ls = require "null-ls"

local b = null_ls.builtins

local sources = {

  -- FORMATTERS
  -- lua
  b.formatting.stylua,

  -- js/ts
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!

  -- C++
  -- b.formatting.clang_format,

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
  b.diagnostics.eslint_d.with {
    filetypes = {
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
    }
  },
  b.formatting.eslint_d.with {
    filetypes = {
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
    }
  },
}

null_ls.setup {
  debug = true,
  sources = sources,
}
