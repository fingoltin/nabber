local palette = require "display.palette"

prism.registerCell("Wall", function()
   return prism.Cell.fromComponents {
      prism.components.Name("WALL"),
      prism.components.Drawable { index = 239, color = palette[7], background = palette[6] },
      prism.components.WallAutoTile(),

      prism.components.Collider(),
      prism.components.Opaque(),
   }
end)
