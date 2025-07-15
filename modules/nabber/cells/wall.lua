local palette = require "display.palette"

prism.registerCell("Wall", function()
   return prism.Cell.fromComponents {
      prism.components.Name("WALL"),
      prism.components.Drawable(239, palette[7], palette[6]),
      prism.components.WallAutoTile(),

      prism.components.Collider(),
      prism.components.Opaque(),
   }
end)
