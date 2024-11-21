return {
  config = function()
    local dap = require "dap"
    ------------
    -- JAVASCRIPT TYPESCRIPT
    ------------
    --
    -- Add the adapter definition
    if not dap.adapters["pwa-node"] then
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          -- 💀 Make sure to update this path to point to your installation
          args = {
            require("mason-registry").get_package("js-debug-adapter"):get_install_path()
              .. "/js-debug/src/dapDebugServer.js",
            "${port}",
          },
        },
      }
    end

    -- Add a configuration
    for _, language in ipairs { "typescript", "javascript", "typescriptreact", "javascriptreact" } do
      if not dap.configurations[language] then
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch current file.",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "launch file with NODE",
            runtimeExecutable = "node",
            runtimeArgs = { "--inspect" },
            program = function()
              return vim.fn.input "File path: ${workspaceFolder}/"
            end,
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            protocol = "inspector",
            console = "integratedTerminal",
            -- attachSimplePort = 6499,
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "launch file with BUN",
            runtimeExecutable = "bun",
            -- runtimeArgs = { "--inspect-brk" },
            runtimeArgs = { "--inspect-wait" },
            program = function()
              return vim.fn.input "File path: ${workspaceFolder}/"
            end,
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            protocol = "inspector",
            console = "integratedTerminal",
            attachSimplePort = 6499,
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch bun",
            cwd = "${workspaceFolder}",
            runtimeArgs = { "--inspect-brk" },
            program = "${file}",
            runtimeExecutable = "bun",
            attachSimplePort = 6499,
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach process",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
        }
      end
    end

    ------------
    -- GO
    ------------
    -- DELVE adapter for GO: https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
    dap.adapters.delve = {
      type = "server",
      port = "${port}",
      executable = {
        command = "dlv",
        args = { "dap", "-l", "127.0.0.1:${port}" },
      },
    }

    -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
    dap.configurations.go = {
      {
        type = "delve",
        name = "Debug",
        request = "launch",
        program = "${file}",
      },
      {
        type = "delve",
        name = "Debug test", -- configuration for debugging test files
        request = "launch",
        mode = "test",
        program = "${file}",
      },
      -- works with go.mod packages and sub packages
      {
        type = "delve",
        name = "Debug test (go.mod)",
        request = "launch",
        mode = "test",
        program = "./${relativeFileDirname}",
      },
    }
  end,
}
