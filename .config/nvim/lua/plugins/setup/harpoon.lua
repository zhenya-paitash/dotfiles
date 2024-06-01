return {
  config = function()
    local harpoon = require "harpoon"
    -- harpoon.setup {}

    vim.keymap.set("n", "<leader>mm", function()
      harpoon:list():add()
    end)
    vim.keymap.set("n", "<leader>ml", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    -- basic telescope configuration
    local config = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers")
        .new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table {
            results = file_paths,
          },
          previewer = config.file_previewer {},
          sorter = config.generic_sorter {},
        })
        :find()
    end

    vim.keymap.set("n", "<leader>sh", function()
      toggle_telescope(harpoon:list())
    end, { desc = "Open harpoon window" })
  end,
}
