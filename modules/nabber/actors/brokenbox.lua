local palette = require "display.palette"

prism.registerActor("BrokenBox", function()
   return prism.Actor.fromComponents {
      prism.components.Name("DEBRIS"),
      prism.components.Position(),
      prism.components.Collider({ allowedMovetypes = { "walk" } }),
      prism.components.Drawable(38, palette[23], palette[6]),
   }
end)
