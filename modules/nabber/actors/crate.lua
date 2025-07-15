local palette = require "display.palette"

prism.registerActor("Crate", function()
   return prism.Actor.fromComponents {
      prism.components.Name("CRATE"),
      prism.components.Position(),
      prism.components.Pushable(),
      prism.components.Drawable(302, palette[24], palette[6], 3),
      prism.components.Collider(),
      prism.components.Drops(prism.actors.BrokenBox),
      prism.components.Opaque(),
      prism.components.Concealable(),
      prism.components.Inventory(),
      prism.components.Health(1),
      prism.components.Suspicious(true),
   }
end)
