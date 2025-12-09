local palette = require "display.palette"

prism.registerActor("BrokenBox", function()
   return prism.Actor.fromComponents {
      prism.components.Name("DEBRIS"),
      prism.components.Position(),
      prism.components.Collider({ allowedMovetypes = { "walk" } }),
      prism.components.Drawable { index = 38, color = palette[23], background = palette[6] },
   }
end)
