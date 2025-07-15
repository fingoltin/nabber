--- @class Suspicious : Component
--- @field onlyWhenMoving boolean
--- @overload fun(onlyWhenMoving?: boolean): Suspicious
local Suspicious = prism.Component:extend "Suspicious"
Suspicious.onlyWhenMoving = false

function Suspicious:__new(onlyWhenMoving)
   self.onlyWhenMoving = onlyWhenMoving
end

return Suspicious
