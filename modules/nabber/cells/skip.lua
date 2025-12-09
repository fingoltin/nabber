local palette = require "display.palette"

prism.registerCell("Skip", function()
   return prism.Cell.fromComponents {
      prism.components.Name("Skip"),
      prism.components.Drawable { index = 128, color = palette[25] },
      prism.components.WallAutoTile(),

      prism.components.Collider({ allowedMovetypes = { "walk" } }),
      prism.components.Skippable(),
   }
end)
