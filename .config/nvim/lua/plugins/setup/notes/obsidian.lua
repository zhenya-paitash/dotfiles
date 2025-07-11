return {
  keys = {
    -- Obsidian Find with Telescope
    { "<leader>ofd", "<cmd> ObsidianDailies <cr>", mode = "n", desc = "Obsidian Dailies" },
    { "<leader>off", "<cmd> ObsidianQuickSwitch <cr>", mode = "n", desc = "Obsidian Quick Switch" },
    { "<leader>ofa", "<cmd> ObsidianSearch <cr>", mode = "n", desc = "Obsidian Search" },
    { "<leader>oft", "<cmd> ObsidianTags <cr>", mode = "n", desc = "Obsidian Tags" },
    { "<leader>ofe", "<cmd> ObsidianTemplate <cr>", mode = "n", desc = "Obsidian Template" },
    { "<leader>ofw", "<cmd> ObsidianWorkspace <cr>", mode = "n", desc = "Obsidian Workspace" },

    -- { "<leader>oy", "<cmd> ObsidianYesterday <cr>", mode = "n", desc = "Obsidian daily Yesterday" },
    { "<leader>oy", "<cmd> ObsidianToday -1 <cr>", mode = "n", desc = "Obsidian daily Yesterday" },
    { "<leader>od", "<cmd> ObsidianToday <cr>", mode = "n", desc = "Obsidian daily Today" },
    { "<leader>ot", "<cmd> ObsidianToday +1 <cr>", mode = "n", desc = "Obsidian daily Tomorrow" },
    -- { "<leader>ot", "<cmd> ObsidianTomorrow <cr>", mode = "n", desc = "Obsidian daily Tomorrow" },

    { "<leader>ob", "<cmd> ObsidianBacklinks <cr>", mode = "n", desc = "Obsidian Back Links" },
    -- { "gf", "<cmd> ObsidianFollowLink <cr>", mode = "n", desc = "Obsidian Follow Link" },
    -- { "gf", "<cmd> ObsidianLink <cr>", mode = "v", desc = "Obsidian Link" },
    { "<leader>ol", "<cmd> ObsidianLinkNew <cr>", mode = "x", desc = "Obsidian Link New" },
    { "<leader>ol", "<cmd> ObsidianLinks <cr>", mode = "n", desc = "Obsidian Links" },

    { "<leader>on", "<cmd> ObsidianNew <cr>", mode = "n", desc = "Obsidian New" },
    { "<leader>oa", "<cmd> ObsidianOpen <cr>", mode = "n", desc = "Obsidian Run Application" },

    { "<leader>oi", "<cmd> ObsidianPasteImg <cr>", mode = "n", desc = "Obsidian Paste Image" },
    { "<leader>or", "<cmd> ObsidianRename <cr>", mode = "n", desc = "Obsidian Rename" },
    { "<leader>oc", "<cmd> ObsidianToggleCheckbox <cr>", mode = "n", desc = "Obsidian Toggle Checkbox" },

    { -- run obsidian & open new tab & open `obsidian` directory
      "<leader>oe",
      function()
        -- TODO: check if `obsidian plugin run`
        require "obsidian"
        vim.cmd "tabnew"
        vim.cmd "tcd ~/obsidian/vault_zhenyapaitash"
        -- vim.cmd "tcd ~/rclone/yadisk/obsidian/zhenyapaitash"
        require("nvim-tree.api").tree.open()
      end,
      mode = "n",
      desc = "Obsidian Explorer",
    },

    { -- sync obsidian with github repository
      "<leader>ogs",
      function()
        local script_path = "$HOME/scripts/obsidian/sync_obsidian syncasync"
        local cmd = "!bash " .. script_path
        vim.api.nvim_command(cmd)
      end,
      mode = "n",
      desc = "Obsidian Yadisk Sync",
    },
  },

  config = function()
    -- сокрытие разметки
    -- vim.opt.conceallevel = 2

    require("obsidian").setup {
      workspaces = {
        { name = "personal", path = "~/obsidian/vault_zhenyapaitash" },
        -- { name = "personal", path = "~/rclone/yadisk/obsidian/zhenyapaitash" },
      },
      completion = {
        nvim_cmp = true,
        min_chars = 1,
      },
      log_level = vim.log.levels.INFO,
      daily_notes = {
        folder = "daily/notes",
        date_format = "%Y-%m-%d",
        alias_format = "%B %-d, %Y",
        template = nil,
        -- tags = { "notes/daily" },
        -- cssclasses = { "daily" },
      },
      mappings = {
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- Toggle check-boxes.
        ["<leader>ch"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
        -- Smart action depending on context, either follow link or toggle checkbox.
        ["<cr>"] = {
          action = function()
            return require("obsidian").util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        },
      },

      -- Where to put new notes. Valid options are
      --  * "current_dir" - put new notes in same directory as the current buffer.
      --  * "notes_subdir" - put new notes in the default notes subdirectory.
      new_notes_location = "notes_subdir",
      -- new_notes_location = "current_dir",

      -- Optional, customize how note IDs are generated given an optional title.
      ---@param title string|?
      ---@return string
      note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
        -- TODO: TRY THIS IMPLEMENTATION LATER
        -- local suffix = ""
        -- if title ~= nil then
        --   -- If title is given, transform it into valid file name.
        --   suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        -- else
        --   -- If title is nil, just add 4 random uppercase letters to the suffix.
        --   for _ = 1, 4 do
        --     suffix = suffix .. string.char(math.random(65, 90))
        --   end
        -- end
        -- return tostring(os.time()) .. "-" .. suffix

        -- DEFAULT
        return tostring(title)
      end,

      -- Optional, customize how note file names are generated given the ID, target directory, and title.
      ---@param spec { id: string, dir: obsidian.Path, title: string|? }
      ---@return string|obsidian.Path The full path to the new note.
      note_path_func = function(spec)
        -- This is equivalent to the default behavior.
        local path = spec.dir / tostring(spec.id)
        return path:with_suffix ".md"
      end,

      -- Optional, customize how wiki links are formatted. You can set this to one of:
      --  * "use_alias_only", e.g. '[[Foo Bar]]'
      --  * "prepend_note_id", e.g. '[[foo-bar|Foo Bar]]'
      --  * "prepend_note_path", e.g. '[[foo-bar.md|Foo Bar]]'
      --  * "use_path_only", e.g. '[[foo-bar.md]]'
      -- Or you can set it to a function that takes a table of options and returns a string, like this:
      wiki_link_func = function(opts)
        return require("obsidian.util").wiki_link_id_prefix(opts)
      end,

      -- Optional, customize how markdown links are formatted.
      markdown_link_func = function(opts)
        return require("obsidian.util").markdown_link(opts)
      end,

      -- Either 'wiki' or 'markdown'.
      preferred_link_style = "wiki",

      -- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
      ---@return string
      image_name_func = function()
        -- Prefix image names with timestamp.
        return string.format("%s-", os.time())
      end,

      -- Optional, boolean or a function that takes a filename and returns a boolean.
      -- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
      disable_frontmatter = false,

      -- Optional, alternatively you can customize the frontmatter data.
      ---@return table
      note_frontmatter_func = function(note)
        -- Add the title of the note as an alias.
        if note.title then
          note:add_alias(note.title)
        end

        local out = {
          id = note.id,
          aliases = note.aliases,
          tags = note.tags,
          cssclasses = note.cssclasses or {},
        }

        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end

        return out
      end,

      -- Optional, for templates (see below).
      templates = {
        folder = "_templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        -- A map for custom variables, the key should be the variable and the value a function
        substitutions = {},
      },

      -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
      -- URL it will be ignored but you can customize this behavior here.
      ---@param url string
      follow_url_func = function(url)
        -- Open the URL in the default web browser.
        vim.fn.jobstart { "open", url } -- Mac OS
        -- vim.fn.jobstart({"xdg-open", url})  -- linux
      end,

      -- Optional, set to true if you use the Obsidian Advanced URI plugin.
      -- https://github.com/Vinzent03/obsidian-advanced-uri
      use_advanced_uri = false,

      -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
      open_app_foreground = false,

      picker = {
        -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
        name = "telescope.nvim",
        -- Optional, configure key mappings for the picker. These are the defaults.
        -- Not all pickers support all mappings.
        mappings = {
          -- Create a new note from your query.
          new = "<C-x>",
          -- Insert a link to the selected note.
          insert_link = "<C-l>",
        },
      },

      -- Optional, sort search results by "path", "modified", "accessed", or "created".
      -- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
      -- that `:ObsidianQuickSwitch` will show the notes sorted by latest modified time
      sort_by = "modified",
      sort_reversed = true,

      -- Optional, determines how certain commands open notes. The valid options are:
      -- 1. "current" (the default) - to always open in the current window
      -- 2. "vsplit" - to open in a vertical split if there's not already a vertical split
      -- 3. "hsplit" - to open in a horizontal split if there's not already a horizontal split
      open_notes_in = "current",

      -- Optional, define your own callbacks to further customize behavior.
      callbacks = {
        -- Runs at the end of `require("obsidian").setup()`.
        ---@param client obsidian.Client
        post_setup = function(client) end,

        -- Runs anytime you enter the buffer for a note.
        ---@param client obsidian.Client
        ---@param note obsidian.Note
        enter_note = function(client, note) end,

        -- Runs anytime you leave the buffer for a note.
        ---@param client obsidian.Client
        ---@param note obsidian.Note
        leave_note = function(client, note) end,

        -- Runs right before writing the buffer for a note.
        ---@param client obsidian.Client
        ---@param note obsidian.Note
        pre_write_note = function(client, note) end,

        -- Runs anytime the workspace is set/changed.
        ---@param client obsidian.Client
        ---@param workspace obsidian.Workspace
        post_set_workspace = function(client, workspace) end,
      },

      -- Optional, configure additional syntax highlighting / extmarks.
      -- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
      ui = {
        enable = true, -- set to false to disable all additional syntax features
        update_debounce = 200, -- update delay after a text change (in milliseconds)
        -- Define how various check-boxes are displayed
        checkboxes = {
          -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
          -- [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
          -- ["x"] = { char = "", hl_group = "ObsidianDone" },
          -- [">"] = { char = "", hl_group = "ObsidianRightArrow" },
          -- ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
          -- Replace the above with this if you don't have a patched font:
          [" "] = { char = "☐", hl_group = "ObsidianTodo" },
          ["x"] = { char = "✔", hl_group = "ObsidianDone" },

          -- You can also add more custom ones...
        },
        -- Use bullet marks for non-checkbox lists.
        bullets = { char = "•", hl_group = "ObsidianBullet" },
        external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        -- Replace the above with this if you don't have a patched font:
        -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        reference_text = { hl_group = "ObsidianRefText" },
        highlight_text = { hl_group = "ObsidianHighlightText" },
        tags = { hl_group = "ObsidianTag" },
        block_ids = { hl_group = "ObsidianBlockID" },
        hl_groups = {
          -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
          ObsidianTodo = { bold = true, fg = COLORS.obsidian_secondary },
          ObsidianDone = { bold = true, fg = COLORS.obsidian_done },
          ObsidianRightArrow = { bold = true, fg = COLORS.obsidian_secondary },
          ObsidianTilde = { bold = true, fg = COLORS.obsidian_highlight },
          ObsidianBullet = { bold = true, fg = COLORS.obsidian_done },
          ObsidianRefText = { underline = true, fg = COLORS.obsidian_primary },
          ObsidianExtLinkIcon = { fg = COLORS.obsidian_primary },
          ObsidianTag = { italic = true, fg = COLORS.obsidian_done },
          ObsidianBlockID = { italic = true, fg = COLORS.obsidian_done },
          ObsidianHighlightText = { bg = COLORS.obsidian_accent },

          -- *DEFAULT THEME*
          -- ObsidianTodo = { bold = true, fg = "#D2C399" },
          -- ObsidianDone = { bold = true, fg = "#F9C767" },
          -- ObsidianRightArrow = { bold = true, fg = "#D2C399" },
          -- ObsidianTilde = { bold = true, fg = "#85B2EE" },
          -- ObsidianBullet = { bold = true, fg = "#F9C767" },
          -- ObsidianRefText = { underline = true, fg = "#9BCA6B" },
          -- ObsidianExtLinkIcon = { fg = "#9BCA6B" },
          -- ObsidianTag = { italic = true, fg = "#F9C767" },
          -- ObsidianBlockID = { italic = true, fg = "#F9C767" },
          -- ObsidianHighlightText = { bg = "#D588F7" },

          -- -- *EVERFOREST THEME*
          -- ObsidianTodo = { bold = true, fg = "#E47D7F" },
          -- ObsidianDone = { bold = true, fg = "#82BE91" },
          -- ObsidianRightArrow = { bold = true, fg = "#E47D7F" },
          -- ObsidianTilde = { bold = true, fg = "#D9BA7E" },
          -- ObsidianBullet = { bold = true, fg = "#82BE91" },
          -- ObsidianRefText = { underline = true, fg = "#7EB78C" },
          -- ObsidianExtLinkIcon = { fg = "#7EB78C" },
          -- ObsidianTag = { italic = true, fg = "#82BE91" },
          -- ObsidianBlockID = { italic = true, fg = "#82BE91" },
          -- ObsidianHighlightText = { bg = "#E0837E" },

          -- *YsDark THEME*
          -- ObsidianTodo = { bold = true, fg = "#D2C399" },
          -- ObsidianDone = { bold = true, fg = "#CBA1A9" },
          -- ObsidianRightArrow = { bold = true, fg = "#D2C399" },
          -- ObsidianTilde = { bold = true, fg = "#85B2EE" },
          -- ObsidianBullet = { bold = true, fg = "#CBA1A9" },
          -- ObsidianRefText = { underline = true, fg = "#85AAFC" },
          -- ObsidianExtLinkIcon = { fg = "#85AAFC" },
          -- ObsidianTag = { italic = true, fg = "#CBA1A9" },
          -- ObsidianBlockID = { italic = true, fg = "#CBA1A9" },
          -- ObsidianHighlightText = { bg = "#D588F7" },
        },
      },

      -- Specify how to handle attachments.
      attachments = {
        -- The default folder to place images in via `:ObsidianPasteImg`.
        -- If this is a relative path it will be interpreted as relative to the vault root.
        -- You can always override this per image by passing a full path to the command instead of just a filename.
        img_folder = "_assets/img", -- This is the default
        -- A function that determines the text to insert in the note when pasting an image.
        -- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
        -- This is the default implementation.
        ---@param client obsidian.Client
        ---@param path obsidian.Path the absolute path to the image file
        ---@return string
        img_text_func = function(client, path)
          -- path = client:vault_relative_path(path) or path
          -- return string.format("![%s](%s)", path.name, path)

          local base = os.date "%Y-%m-%d-%H-%M-%S"
          local png = path:parent() / (base .. ".png")
          local webp = path:parent() / (base .. ".webp")

          -- Переименовываем файл как .png
          path:rename(png)

          -- Асинхронно конвертируем в webp и удаляем png
          vim.defer_fn(function()
            os.execute(string.format('mogrify -format webp "%s"', tostring(png)))
            os.remove(tostring(png))
          end, 10)

          -- Возвращаем ссылку как Markdown (название = имя файла, путь = относительный путь)
          local rel_path = client:vault_relative_path(webp) or tostring(webp)
          return string.format("![%s](%s)", base .. ".webp", rel_path)
        end,
      },
    }
  end,
}
