local palette = require "display.palette"

local on = prism.components.Drawable {
   index = "!",
   color = prism.Color4.WHITE,
   background = prism.Color4.BLACK,
   layer = 4,
}
local off = prism.components.Drawable {
   index = " ",
   color = prism.Color4.WHITE,
   background = prism.Color4.BLACK,
   layer = 0,
}
local function putAround(display, x, y)
   display:put(x + 1, y, "!", prism.Color4.WHITE, prism.Color4.BLACK, 1)
   display:put(x - 1, y, "!", prism.Color4.WHITE, prism.Color4.BLACK, 1)
   display:put(x, y + 1, "!", prism.Color4.WHITE, prism.Color4.BLACK, 1)
   display:put(x, y - 1, "!", prism.Color4.WHITE, prism.Color4.BLACK, 1)
end

spectrum.registerAnimation("Exclamation", function()
   return spectrum.Animation({ on, off, on }, 0.15, "pauseAtEnd")
end)
