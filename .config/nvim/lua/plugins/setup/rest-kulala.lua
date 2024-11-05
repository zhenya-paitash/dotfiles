return {
  config = function()
    require("kulala").setup {
      -- https://kulala.mwco.app/docs/getting-started/configuration-options

      display_mode = "float", -- "float", "split"
      -- split_direction = "vertical", -- "vertical" | "horizontal"

      default_env = "dev", -- dev, test, prod, can be anything | see: https://learn.microsoft.com/en-us/aspnet/core/test/http-files?view=aspnetcore-8.0#environment-files
      debug = true, -- enable/disable debug mode
      -- contenttypes = {
      --   ["application/json"] = {
      --     ft = "json",
      --     formatter = { "jq", "." },
      --     pathresolver = require("kulala.parser.jsonpath").parse,
      --   },
      --   ["application/xml"] = {
      --     ft = "xml",
      --     formatter = { "xmllint", "--format", "-" },
      --     pathresolver = { "xmllint", "--xpath", "{{path}}", "-" },
      --   },
      --   ["text/html"] = {
      --     ft = "html",
      --     formatter = { "xmllint", "--format", "--html", "-" },
      --     pathresolver = {},
      --   },
      -- },

      show_icons = "on_request", -- "on_request" | "above_request" | "below_request" | nil
      icons = {
        inlay = {
          loading = "  ",
          done = " ",
          error = " ",
        },
        lualine = "🐼",
      },

      -- additional cURL options
      -- see: https://curl.se/docs/manpage.html
      -- additional_curl_options = {},

      -- scratchpad default contents
      scratchpad_default_contents = {
        "@MY_TOKEN_NAME=my_token_value",
        "",
        "# @name scratchpad",
        "POST https://httpbin.org/post HTTP/1.1",
        "accept: application/json",
        "content-type: application/json",
        "",
        "{",
        '  "foo": "bar"',
        "}",
      },

      winbar = true, -- true | false

      default_winbar_panes = { "body", "headers", "headers_body", "stats" }, -- { "body", "headers", "headers_body", "script_output", "stats" },

      -- enable reading vscode rest client environment variables
      vscode_rest_client_environmentvars = false,

      -- disable the vim.print output of the scripts
      -- they will be still written to disk, but not printed immediately
      disable_script_print_output = false,

      -- set scope for environment and request variables
      environment_scope = "b", -- possible values: b = buffer, g = global

      -- certificates
      certificates = {},
    }
  end,
}
