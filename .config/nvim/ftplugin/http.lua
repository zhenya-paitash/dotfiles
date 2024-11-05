-- Выполнить запрос
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<CR>",
  "<cmd>lua require('kulala').run()<cr>",
  { noremap = true, silent = true, desc = "Execute the request" }
)

-- Переход между запросами
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "[",
  "<cmd>lua require('kulala').jump_prev()<cr>",
  { noremap = true, silent = true, desc = "Jump to the previous request" }
)
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "]",
  "<cmd>lua require('kulala').jump_next()<cr>",
  { noremap = true, silent = true, desc = "Jump to the next request" }
)

-- Осмотрите текущий запрос
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<leader>i",
  "<cmd>lua require('kulala').inspect()<cr>",
  { noremap = true, silent = true, desc = "Inspect the current request" }
)

-- Переключайте корпус и заголовки
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<leader>t",
  "<cmd>lua require('kulala').toggle_view()<cr>",
  { noremap = true, silent = true, desc = "Toggle between body and headers" }
)

-- Копировать как завиток
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<leader>co",
  "<cmd>lua require('kulala').copy()<cr>",
  { noremap = true, silent = true, desc = "Copy the current request as a curl command" }
)

-- Вставить из завитка
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<leader>ci",
  "<cmd>lua require('kulala').from_curl()<cr>",
  { noremap = true, silent = true, desc = "Paste curl from clipboard as http request" }
)


-- CUSTOM
