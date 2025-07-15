local palette = require "display.palette"

prism.registerActor("PipeDoor", function()
   return prism.Actor.fromComponents {
      prism.components.Name("DOOR"),
      prism.components.Position(),
      prism.components.Drawable(143, palette[17], palette[6]),

      prism.components.Opaque(),
      prism.components.Door({
         open = false,
         openDrawable = prism.components.Drawable(142, palette[17], palette[6]),
         closedDrawable = prism.components.Drawable(143, palette[17], palette[6]),
      }),
      prism.components.Collider(),
   }
end)
