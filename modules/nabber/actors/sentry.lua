local palette = require "display.palette"

prism.registerActor("Sentry", function()
   return prism.Actor.fromComponents {
      prism.components.Name("SENTRY"),
      prism.components.Position(),
      prism.components.Drawable(349, palette[27], palette[6], 3),
      prism.components.Collider(),
      prism.components.Senses(),
      prism.components.Sight { range = 2, fov = true },
      prism.components.Mover { "walk" },
      prism.components.Alarm(),
      prism.components.SentryContoller(),
      prism.components.Health(2),
   }
end)
