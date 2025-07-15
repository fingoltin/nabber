local palette = require "display.palette"
local Drawable = prism.components.Drawable

--- @class PitAutoTile : AutoTile
local PitAutoTile = prism.components.AutoTile:extend("PitAutoTile")

PitAutoTile.default = Drawable(1, nil, palette[5])
PitAutoTile.id = 6
PitAutoTile.rules = {}

return PitAutoTile
