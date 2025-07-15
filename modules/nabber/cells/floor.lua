local palette = require "display.palette"

prism.registerCell("Floor", function()
   return prism.Cell.fromComponents {
      prism.components.FloorAutoTile(),
      prism.components.Name("FLOOR"),
      prism.components.Drawable(271, palette[5], palette[6]),

      prism.components.Collider({ allowedMovetypes = { "walk", "fly" } }),
   }
end)
