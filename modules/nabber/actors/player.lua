local palette = require "display.palette"

prism.registerActor("Player", function()
   local player = prism.Actor.fromComponents {
      prism.components.Drawable {
         index = 2,
         color = palette[20],
         background = palette[6],
         layer = 3,
      },
      prism.components.Name("YOU"),
      prism.components.Suspicious(),
      prism.components.IdleAnimation("Player"),

      prism.components.Health(6),
      prism.components.Collider(),
      prism.components.Position(),
      prism.components.PlayerController(),
      prism.components.Senses(),
      prism.components.Sight { range = 2, fov = true },
      prism.components.Mover { "walk" },
      prism.components.Inventory { multipleStacks = false },
      prism.components.Equipment("pilot"),
   }

   return player
end)
