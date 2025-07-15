local palette = require "display.palette"

prism.registerActor("Player", function()
   return prism.Actor.fromComponents {
      prism.components.Drawable(2, palette[20], palette[6], 3),
      prism.components.Name("YOU"),
      prism.components.Suspicious(),

      prism.components.Health(6),
      prism.components.Collider(),
      prism.components.Position(),
      prism.components.PlayerController(),
      prism.components.Senses(),
      prism.components.Sight { range = 2, fov = true },
      prism.components.Mover { "walk" },
      prism.components.Inventory { multipleStacks = false },
   }
end)
