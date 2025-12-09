local palette = require "display.palette"

prism.registerActor("Terminal", function()
   return prism.Actor.fromComponents {
      prism.components.Name("TERM"),
      prism.components.Drawable { index = 301, color = palette[15], background = palette[6] },
      prism.components.Collider(),
      prism.components.Hackable(true),
      prism.components.Position(),
   }
end)
