local palette = require "display.palette"
local anim = require "display.animation"

prism.registerActor("Terminal", function()
   return prism.Actor.fromComponents {
      prism.components.Name("TERM"),
      prism.components.Drawable(301, palette[15], palette[6]),
      prism.components.Collider(),
      prism.components.Hackable(true),
      prism.components.Position(),

      prism.components.IdleAnimation(anim.newAnimation({
         function(display, x, y)
            display:put(x, y, 301, palette[15], palette[5], 5)
         end,
         function(display, x, y)
            display:put(x, y, 302, palette[15], palette[5], 5)
         end,
      }, { 1, 1 })),
   }
end)
