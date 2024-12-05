return {
  config = function()
    local dap = require "dap"

    vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticSignError" })

    --┌───────────┬─────────────────────────────────────────────────────────────┐
    --├ @language   Javascript | Typescript | JSX | TSX
    --└───────────┴─────────────────────────────────────────────────────────────┘
    local javascript_adapter = require "plugins.setup.debug.adapters.javascript"
    dap.adapters[javascript_adapter.adapter.name] = javascript_adapter.adapter
    for _, language in ipairs(javascript_adapter.languages) do
      if not dap.configurations[language] then
        dap.configurations[language] = javascript_adapter.adapterConfigs
      end
    end

    --┌───────────┬─────────────────────────────────────────────────────────────┐
    --├ @language   GO
    --└───────────┴─────────────────────────────────────────────────────────────┘
    -- local go_adapter = require "plugins.setup.debug.adapters.go"
    -- dap.adapters[go_adapter.adapter.name] = go_adapter.adapter
    -- for _, language in ipairs(go_adapter.languages) do
    --   if not dap.configurations[language] then
    --     dap.configurations[language] = go_adapter.adapterConfigs
    --   end
    -- end
  end,
}
