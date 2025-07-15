--- @class AutoTileRule
--- @field drawable string
--- @field pattern integer[]
--- @field mirrorX boolean
--- @field mirrorY boolean

--- @class AutoTile : Component
--- @field drawables table<string, Drawable[]>
--- @field default Drawable
--- @field rules AutoTileRule[]
--- @field id integer
local AutoTile = prism.Component:extend("AutoTile")

return AutoTile
