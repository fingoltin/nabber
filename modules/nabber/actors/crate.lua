local palette = require "display.palette"

prism.registerActor("Crate", function()
   return prism.Actor.fromComponents {
      prism.components.Name("CRATE"),
      prism.components.Position(),
      prism.components.Pushable(),
      prism.components.Drawable {
         index = 302,
         color = palette[24],
         background = palette[6],
         layer = 3,
      },
      prism.components.Collider(),
      prism.components.Drops(prism.actors.BrokenBox),
      prism.components.Opaque(),
      prism.components.Concealable(),
      prism.components.Inventory(),
      prism.components.Health(1),
      prism.components.Suspicious(true),
      prism.components.Equipper { "pilot" },
   }
end)
