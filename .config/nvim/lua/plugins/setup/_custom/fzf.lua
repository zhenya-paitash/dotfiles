local M = {}

M.run_fzf = function()
  -- Создаем окно и буфер
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = math.floor(vim.o.columns * 0.8),
    height = math.floor(vim.o.lines * 0.8),
    col = math.floor(vim.o.columns * 0.1),
    row = math.floor(vim.o.lines * 0.1),
    style = "minimal",
    border = "rounded",
  })

  -- Включаем режим ввода
  vim.api.nvim_buf_set_option(buf, "buftype", "prompt")
  vim.cmd "startinsert"

  -- Запускаем системный fzf
  -- vim.fn.termopen("/usr/bin/fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'", {
  -- vim.fn.termopen('/usr/bin/fzf --walker-skip="" --preview "bat --color=always {}" --inline-info --layout reverse --bind ctrl-u:preview-page-up,ctrl-d:preview-page-down,"ctrl-y:execute-silent(readlink -f {} | wl-copy -n)+abort"', {
  vim.fn.termopen("fzfa --height 100%", {
    on_exit = function(_, code, _)
      -- Закрываем окно и буфер, если fzf завершился
      vim.api.nvim_win_close(win, true)
      if code ~= 0 then
        print("Ошибка: fzf завершился с кодом " .. code)
      else
        -- Читаем результат из буфера
        local result = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        if #result > 0 and result[1] ~= "" then
          vim.cmd("edit " .. result[1])
        end
      end
    end,
  })
end

vim.api.nvim_create_user_command("CustomFzf", M.run_fzf, {})

return M
