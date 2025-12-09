local palette = require "display.palette"

prism.registerCell("PipeDoorClosed", function()
   return prism.Cell.fromComponents {
      prism.components.Name("PIPE"),
      prism.components.Collider({ allowedMovetypes = { "walk" } }),
      prism.components.Drawable { index = 158, color = palette[26], background = palette[17] },
      prism.components.Seen(
         prism.components.Drawable { index = 271, color = palette[5], background = palette[6] }
      ),
      prism.components.Dark(),
   }
end)
