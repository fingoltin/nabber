local palette = require "display.palette"

prism.registerCell("PipeDoorClosed", function()
   return prism.Cell.fromComponents {
      prism.components.Name("PIPE"),
      prism.components.Collider({ allowedMovetypes = { "walk" } }),
      prism.components.Drawable(158, palette[26], palette[17]),
      prism.components.Seen(prism.components.Drawable(271, palette[5], palette[6])),
      prism.components.Dark(),
   }
end)
