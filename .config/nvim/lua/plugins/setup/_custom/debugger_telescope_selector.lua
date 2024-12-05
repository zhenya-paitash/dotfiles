local M = {}

M.pick_debugger = function()
  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"
  local pickers = require "telescope.pickers"
  local finders = require "telescope.finders"
  local conf = require("telescope.config").values
  local previewers = require "telescope.previewers"
  local dap = require "dap"

  local opts = {}

  -- Проверяем, есть ли конфигурации для JavaScript
  local configs = dap.configurations.javascript or {}
  if #configs == 0 then
    vim.notify("No DAP configurations found for JavaScript", vim.log.levels.WARN)
    return
  end

  -- Генерируем список имен конфигураций
  local config_names = {}
  for i, config in ipairs(configs) do
    table.insert(config_names, config.name or ("Config " .. i))
  end

  -- Кастомный превьюер для отображения JSON-представления конфигурации
  local function config_previewer(entry, _)
    for _, config in ipairs(configs) do
      if config.name == entry then
        return vim.inspect(config) -- Преобразуем конфиг в читаемую строку
      end
    end
    return "No configuration found."
  end

  pickers
    .new(opts, {
      prompt_title = "Select DAP Configuration",
      finder = finders.new_table {
        results = config_names,
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry,
            ordinal = entry,
          }
        end,
      },
      sorter = conf.generic_sorter(opts),
      previewer = previewers.new_buffer_previewer {
        define_preview = function(self, entry)
          local preview_content = config_previewer(entry.value, configs)
          vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, vim.split(preview_content, "\n"))
        end,
      },
      attach_mappings = function(_, map)
        map("i", "<CR>", function(prompt_bufnr)
          local selection = action_state.get_selected_entry(prompt_bufnr)
          actions.close(prompt_bufnr)
          if selection then
            -- Ищем выбранную конфигурацию и запускаем её
            for _, config in ipairs(configs) do
              if config.name == selection.value then
                dap.run(config)
                return
              end
            end
          end
        end)
        return true
      end,
    })
    :find()
end

-- M.pick_process = function(callback)
--   local pickers = require "telescope.pickers"
--   local finders = require "telescope.finders"
--   local conf = require("telescope.config").values
--   local actions = require "telescope.actions"
--   local action_state = require "telescope.actions.state"
--
--   -- Получаем список процессов через системную команду `ps`
--   local handle = io.popen("ps -eo pid,comm")
--   if not handle then
--     vim.notify("Failed to retrieve processes", vim.log.levels.ERROR)
--     return
--   end
--
--   local result = handle:read("*a")
--   handle:close()
--
--   local processes = {}
--   for line in result:gmatch("[^\r\n]+") do
--     local pid, command = line:match("(%d+)%s+(.+)")
--     if pid and command then
--       table.insert(processes, { pid = tonumber(pid), command = command })
--     end
--   end
--
--   -- Создаём Telescope picker
--   pickers
--     .new({}, {
--       prompt_title = "Select Process",
--       finder = finders.new_table {
--         results = processes,
--         entry_maker = function(proc)
--           return {
--             value = proc.pid,
--             display = string.format("%s (%d)", proc.command, proc.pid),
--             ordinal = proc.command,
--           }
--         end,
--       },
--       sorter = conf.generic_sorter({}),
--       attach_mappings = function(_, map)
--         map("i", "<CR>", function(prompt_bufnr)
--           local selection = action_state.get_selected_entry(prompt_bufnr)
--           actions.close(prompt_bufnr)
--           if selection then
--             callback(selection.value) -- Передаём выбранный PID
--           end
--         end)
--         return true
--       end,
--     })
--     :find()
-- end

return M
