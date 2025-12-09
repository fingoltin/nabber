local palette = require "display.palette"
local Drawable = prism.components.Drawable

--- @class FloorAutoTile : AutoTile
local FloorAutoTile = prism.components.AutoTile:extend("FloorAutoTile")

FloorAutoTile.default = Drawable { index = 271, color = palette[5], background = palette[6] }
FloorAutoTile.id = 5
FloorAutoTile.drawables = {
   ["bridge"] = Drawable { index = 257, color = palette[4], background = palette[5] },
   ["bridge-v"] = Drawable { index = 258, color = palette[4], background = palette[5] },
   ["bridge-m"] = Drawable { index = 277, color = palette[4], background = palette[5] },
}
-- stylua: ignore start
FloorAutoTile.rules = {
   {
      drawable = "bridge-m",
      pattern = {
         0,6,0,
         6,3,6,
         0,6,0
      },
   },
   {
      drawable = "bridge-m",
      pattern = {
         0,2,0,
         2,3,2,
         0,6,0
      },
      mirrorY = true,
      mirrorX = true
   },
   {
      drawable = "bridge-m",
      pattern = {
         0,2,0,
         2,3,0,
         0,6,0
      },
      mirrorY = true,
      mirrorX = true
   },
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
