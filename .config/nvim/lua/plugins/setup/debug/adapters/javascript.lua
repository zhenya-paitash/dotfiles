local debugger_path = require("mason-registry").get_package("js-debug-adapter"):get_install_path() .. "/js-debug/src/dapDebugServer.js"

local M = {}

M.languages = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

M.adapter = {
  name = "pwa-node",
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = { debugger_path, "${port}" },
  },
}

M.adapterConfigs = {
  --------------------------------------------------------------------------------------
  --- OLD
  --------------------------------------------------------------------------------------
  {
    type = "pwa-node",
    request = "launch",
    name = "OLD: Launch current file",
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
  {
    type = "pwa-node",
    request = "launch",
    name = "OLD: launch file with NODE",
    runtimeExecutable = "node",
    runtimeArgs = { "--inspect" },
    program = function()
      return vim.fn.input "File path: ${workspaceFolder}/"
    end,
    cwd = "${workspaceFolder}",
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
  },
  {
    type = "pwa-node",
    request = "launch",
    name = "OLD: launch file with BUN",
    runtimeExecutable = "bun",
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
    name = "OLD: Launch bun",
    cwd = "${workspaceFolder}",
    runtimeArgs = { "--inspect-brk" },
    program = "${file}",
    runtimeExecutable = "bun",
    attachSimplePort = 6499,
  },

  -------------------------------------------------------------
  -- TRY
  {
    type = "pwa-node",
    request = "launch",
    name = "OLD: CUSTOM: for next.js npm run dev",
    cwd = vim.fn.getcwd(),
    -- skipFiles = { "<node_internals>/**", "node_modules/**" },
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",

    runtimeExecutable = "node",
    program = "${workspaceFolder}/node_modules/next/dist/bin/next",
    -- runtimeArgs = { "NODE_OPTIONS='--inspect'" },
    args = { "dev" },
  },

  {
    type = "pwa-node",
    request = "launch",
    name = "OLD: Launch Bun (Dev Server)",
    cwd = "${workspaceFolder}",
    runtimeExecutable = "bun",
    runtimeArgs = { "--inspect-wait", "run", "dev" },
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
    attachSimplePort = 6499, -- Стандартный порт для Node.js
  },
  {
    type = "pwa-node",
    request = "launch",
    name = "OLD: TEST",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
    runtimeExecutable = "node",
    runtimeArgs = { "--inspect-brk", "run-script" },
    args = { "dev" },
    attachSimplePort = 9229,
  },

  {
    type = "pwa-node",
    request = "launch",
    name = "OLD: Launch Next.js (WORK)",
    program = "${workspaceFolder}/node_modules/next/dist/bin/next",
    args = { "dev" },
    cwd = "${workspaceFolder}",
    runtimeExecutable = "node",
    runtimeArgs = { "--inspect" },
    -- runtimeArgs = { "--inspect-brk" },
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
  },
  {
    type = "pwa-node",
    request = "launch",
    name = "OLD: Launch Next.js v2",
    program = "${workspaceFolder}",
    args = { "dev" },
    cwd = "${workspaceFolder}",
    runtimeExecutable = "node",
    runtimeArgs = { "--inspect-brk" },
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
    preLaunchTask = "npm:dev",
  },

  -- @link: https://stackoverflow.com/questions/78455585/correct-setup-for-debugging-nextjs-app-inside-neovim-with-dap
  {
    name = "OLD: Next.js: debug server-side",
    type = "pwa-node",
    request = "attach",
    port = 9231,
    skipFiles = { "<node_internals>/**", "node_modules/**" },
    cwd = "${workspaceFolder}",
  },
  {
    name = "OLD: Next.js: debug client-side",
    type = "chrome",
    request = "launch",
    url = "http://localhost:3000",
    webRoot = "${workspaceFolder}",
    sourceMaps = true, -- https://github.com/vercel/next.js/issues/56702#issuecomment-1913443304
    sourceMapPathOverrides = {
      ["webpack://_N_E/*"] = "${webRoot}/*",
    },
  },
  {
    type = "pwa-node",
    request = "attach",
    name = "OLD: Attach process",
    processId = require("dap.utils").pick_process,
    cwd = "${workspaceFolder}",
  },
  {
    type = "pwa-node",
    request = "attach",
    name = "OLD: Auto Attach",
    cwd = vim.fn.getcwd(),
  },
  {
    type = "pwa-node",
    request = "attach",
    name = "OLD: Attach process by ID",
    processId = function()
      vim.fn.input "Enter process ID: "
    end,
    cwd = "${workspaceFolder}",
  },

  -- @desc: TRY! get from other config file
  -- @link: https://github.com/lucaSartore/nvim/blob/master/lua/plugins/dap.lua#L95
  -- --
  {
    type = "pwa-node",
    request = "launch",
    name = "OLD: CUSTOM: Launch with BUN",
    cwd = vim.fn.getcwd(),
    runtimeArgs = { "--inspect-brk", "--allow-all", "dev" },
    runtimeExecutable = "bun",
    smartStep = true,
    console = "integratedTerminal",
    attachSimplePort = 9229,
  },

  --------------------------------------------------------------------------------------
  --- NEW
  --------------------------------------------------------------------------------------
  -- Серверная часть (SSR)
  {
    name = "OLD: next(SSR): Debug Server (Node.js)",
    type = "pwa-node",
    request = "launch",
    runtimeExecutable = "node",
    runtimeArgs = { "--inspect" },
    program = "${workspaceFolder}/node_modules/next/dist/bin/next",
    args = { "dev" },
    cwd = "${workspaceFolder}",
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
  },
  -- Подключение к уже запущенному серверу
  {
    name = "OLD: next(CSR): Attach to Running Server",
    type = "pwa-node",
    request = "attach",
    port = 9229,
    cwd = "${workspaceFolder}",
    sourceMaps = true,
    protocol = "inspector",
    skipFiles = { "<node_internals>/**", "node_modules/**" },
  },

  --------------------------------------------------------------------------------------
  --- NEW NEW
  --------------------------------------------------------------------------------------
  {
    type = "pwa-node",
    request = "launch",
    name = "NEW: Launch TS file with ts-node (ESM loader)",
    program = "${file}",
    cwd = "${workspaceFolder}",
    runtimeExecutable = "node",
    runtimeArgs = {
      "--loader",
      "ts-node/esm",
      "--no-warnings",
    },
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
    internalConsoleOptions = "neverOpen",
    skipFiles = { "<node_internals>/**" },
    resolveSourceMapLocations = {
      "${workspaceFolder}/**",
      "!**/node_modules/**",
    },
  },
}

return M
