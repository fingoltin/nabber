local palette = require "display.palette"

prism.registerActor("PipeDoor", function()
   return prism.Actor.fromComponents {
      prism.components.Name("DOOR"),
      prism.components.Position(),
      prism.components.Drawable { index = 143, color = palette[17], background = palette[6] },

      prism.components.Opaque(),
      prism.components.Door({
         open = false,
         openDrawable = prism.components.Drawable {
            index = 142,
            color = palette[17],
            background = palette[6],
         },
         closedDrawable = prism.components.Drawable {
            index = 143,
            color = palette[17],
            background = palette[6],
         },
      }),
      prism.components.Collider(),
   }
end)

prism.registerActor("PipeDoorOpen", function()
   local door = prism.actors.PipeDoor()
   door:remove(prism.components.Collider)
   local component = door:expect(prism.components.Door)
   component.open = true
   door:give(component.openDrawable)
   return door
end)
