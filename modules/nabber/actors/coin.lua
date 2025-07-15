local palette = require "display.palette"

prism.registerActor("Coin", function()
   return prism.Actor.fromComponents {
      prism.components.Name("COIN"),
      prism.components.Item { stackable = prism.actors.Coin, stackLimit = 9 },
      prism.components.Drawable(44, palette[12], palette[6], 2),
      prism.components.Position(),
      prism.components.Coin(),
   }
end)
