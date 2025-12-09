local palette = require "display.palette"

prism.registerCell("Pit", function()
   return prism.Cell.fromComponents {
      prism.components.Drawable { index = 1, background = palette[5] },
      prism.components.Name("PIT"),

      prism.components.Opaque(),
      prism.components.Collider({ allowedMovetypes = { "fly" } }),
      prism.components.PitAutoTile(),
   }
end)
