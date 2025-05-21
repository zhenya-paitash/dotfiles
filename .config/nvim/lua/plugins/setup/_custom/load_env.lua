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

vim.env.GROQ_API_KEY = read_env_file(vim.fn.expand "~/private/GROQ_API_KEY")
vim.env.OPENAI_API_KEY = read_env_file(vim.fn.expand "~/private/OPENAI_API_KEY")
vim.env.ANTHROPIC_API_KEY = read_env_file(vim.fn.expand "~/private/ANTHROPIC_API_KEY")
vim.env.DEEPSEEK_API_KEY = read_env_file(vim.fn.expand "~/private/DEEPSEEK_API_KEY")
vim.env.HUGGINGFACE_API_KEY = read_env_file(vim.fn.expand "~/private/HUGGINGFACE_API_KEY")
