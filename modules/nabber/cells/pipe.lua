local palette = require "display.palette"

prism.registerCell("Pipe", function()
   return prism.Cell.fromComponents {
      prism.components.Name("PIPE"),
      prism.components.PipeAutoTile(),
      prism.components.Drawable { index = 159, color = palette[6], background = palette[17] },
      prism.components.Dark(),
      prism.components.Seen(
         prism.components.Drawable { index = 271, color = palette[5], background = palette[6] }
      ),
      prism.components.Collider({ allowedMovetypes = { "walk" } }),
   }
end)
