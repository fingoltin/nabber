local palette = require "display.palette"
local Drawable = prism.components.Drawable

--- @class FloorAutoTile : AutoTile
local FloorAutoTile = prism.components.AutoTile:extend("FloorAutoTile")

FloorAutoTile.default = Drawable(271, palette[5], palette[6])
FloorAutoTile.id = 5
FloorAutoTile.drawables = {
   ["bridge"] = Drawable(257, palette[4], palette[5]),
   ["bridge-v"] = Drawable(258, palette[4], palette[5]),
}
-- stylua: ignore start
FloorAutoTile.rules = {
   {
      drawable = "bridge",
      pattern = {
         0,6,0,
         0,3,0,
         0,6,0
      },
   },
   {
      drawable = "bridge-v",
      pattern = {
         0,0,0,
         6,3,6,
         0,0,0
      },
   },
}
-- stylua: ignore end

return FloorAutoTile
