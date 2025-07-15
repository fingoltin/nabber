local palette = require "display.palette"

prism.registerCell("Pipe", function()
   return prism.Cell.fromComponents {
      prism.components.Name("PIPE"),
      prism.components.PipeAutoTile(),
      prism.components.Drawable(159, palette[6], palette[17]),
      prism.components.Dark(),
      prism.components.Seen(prism.components.Drawable(271, palette[5], palette[6])),

      prism.components.Collider({ allowedMovetypes = { "walk" } }),
   }
end)
