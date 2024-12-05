local function read_env_file(path)
  local file = io.open(path, "r")
  if file then
    local key = file:read("*all"):gsub("%s+", "") -- Убирает пробелы/переносы строк
    file:close()
    return key
  else
    return nil
  end
end

vim.env.OPENAI_API_KEY = read_env_file(vim.fn.expand "~/private/OPENAI_API_KEY")
