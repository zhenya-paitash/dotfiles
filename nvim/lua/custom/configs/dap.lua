local config = function()
  local dap = require "dap"

  -- Add the adapter definition
  if not dap.adapters["pwa-node"] then
    require("dap").adapters["pwa-node"] = {
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
end

return config
