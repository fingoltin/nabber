local palette = require "display.palette"

prism.registerCell("Floor", function()
   return prism.Cell.fromComponents {
      prism.components.FloorAutoTile(),
      prism.components.Name("FLOOR"),
      prism.components.Drawable { index = 271, color = palette[5], background = palette[6] },

      prism.components.Collider({ allowedMovetypes = { "walk", "fly" } }),
   }
end)
