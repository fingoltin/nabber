local Drawable = require "prism.spectrum.components.drawable"
local palette = require "display.palette"
local default = Drawable { index = 1, color = palette[17] }

--- @class PipeDecorAutoTile : AutoTile
local PipeDecorAutoTile = prism.components.AutoTile:extend("PipeDecorAutoTile")

PipeDecorAutoTile.id = 8
PipeDecorAutoTile.default = default

PipeDecorAutoTile.drawables = {
   ["top-right"] = Drawable { index = 140, color = palette[17] },
   ["top-left"] = Drawable { index = 138, color = palette[17] },
}

-- stylua: ignore start
PipeDecorAutoTile.rules = {
   {
      drawable = "top-left",
      pattern = {
         0, 0, 0,
         1, 3, 6,
         0, 4, 0
      }
   },
   {
      drawable = "top-right",
      pattern = {
         0, 0, 0,
         6, 3, 1,
         0, 4, 0
      }
   },
}
-- stylua: ignore end

return PipeDecorAutoTile
