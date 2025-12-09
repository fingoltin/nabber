local palette = require "display.palette"
spectrum.registerAnimation("Player", function()
   return spectrum.Animation({
      { index = 2, color = palette[20], background = palette[6], layer = 3 },
      { index = 369, color = palette[20], background = palette[6], layer = 3 },
   }, 1)
end)
