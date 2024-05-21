return {
  config = function()
    -- ccc.nvim settings
    local ccc = require "ccc"

    -- Define the colorspace conversion table
    local conversions = {
      -- Hex to RGB
      { "#", "rgb" },
      -- RGB to Hex
      { "rgb", "#" },
      -- HSL to RGB
      { "hsl", "rgb" },
      -- RGB to HSL
      { "rgb", "hsl" },
    }

    -- Set the default colorspace (RGB)
    local default_colorspace = "rgb"

    -- Define a function to convert a color value to the desired format
    local function convert_color(value, from_colorspace, to_colorspace)
      if from_colorspace == "hex" then
        -- Convert hex to RGB (or HSL if requested)
        local r, g, b = ccc.hex_to_rgb(value)
        if to_colorspace == "hsl" then
          return ccc.rgb_to_hsl(r, g, b)
        else
          return string.format("%d, %d, %d", r, g, b)
        end
      elseif from_colorspace == "rgb" then
        -- Convert RGB (or HSL if requested) to hex or HSL
        local h, s, l = ccc.rgb_to_hsl(value[1], value[2], value[3])
        if to_colorspace == "hex" then
          return ccc.hsl_to_hex(h, s, l)
        else
          return string.format("%.2f, %.2f, %.2f", h, s, l)
        end
      elseif from_colorspace == "hsl" then
        -- Convert HSL to RGB (or hex if requested)
        local r, g, b = ccc.hsl_to_rgb(value[1], value[2], value[3])
        if to_colorspace == "hex" then
          return ccc.rgb_to_hex(r, g, b)
        else
          return string.format("%d, %d, %d", r, g, b)
        end
      end
    end

    -- Create the conversion table for `ccc.nvim`
    local function create_conversions()
      local conversions_table = {}
      for from_colorspace, to_colorspace in pairs(conversions) do
        table.insert(conversions_table, { from = from_colorspace, to = to_colorspace })
      end
      return conversions_table
    end

    -- Create the conversion table and set the default colorspace
    local ccc_conversions = create_conversions()
    ccc.set_conversions(ccc_conversions)
    ccc.set_default_colorspace(default_colorspace)

    -- Example usage:
    -- Convert a hex color value to RGB
    -- :echom "Hello" | ccc.ccc("#FF0000", 'hex', 'rgb')

    -- Convert an RGB color value to HSL
    -- :echom "World" | ccc.ccc("255, 0, 0", 'rgb', 'hsl')

    -- This configuration defines a table of conversions between different
    -- colorspace formats (hex, RGB, and HSL). The `convert_color` function
    -- takes three arguments: the color value to convert, the original
    -- colorspace, and the desired colorspace. It uses these inputs to
    -- perform the conversion using the `ccc` plugin's built-in functions.
    --
    -- The `create_conversions` function generates a table of conversions
    -- based on the `conversions` table defined earlier. This table is then
    -- passed to the `ccc.set_conversions` function to set up the conversion
    -- system for `ccc.nvim`.
    --
    -- Finally, you can use this configuration by calling the `ccc.ccc`
    -- function with the desired inputs (e.g., converting a hex color
    -- value to RGB).
    --
    -- Feel free to modify this example to suit your specific needs and
    -- preferences! 😊

    -- -- Enable true color
    -- vim.opt.termguicolors = true
    --
    -- local ccc = require "ccc"
    -- local mapping = ccc.mapping
    --
    -- ccc.setup {
    --   -- Your preferred settings
    --   -- Example: enable highlighter
    --   highlighter = {
    --     auto_enable = true,
    --     lsp = true,
    --   },
    -- }

    require("ccc").setup {}
  end,
}
