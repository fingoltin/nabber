local palette = require "display.palette"

prism.registerActor("Coin", function()
   return prism.Actor.fromComponents {
      prism.components.Name("COIN"),
      prism.components.Item { stackable = "coin", stackLimit = 9 },
      prism.components.Drawable { index = 44, color = palette[12], background = palette[6], layer = 2 },
      prism.components.Position(),
      prism.components.Coin(),
   }
end)
