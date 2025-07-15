--- @class ParentPickup : Action
local ParentPickup = prism.actions.Pickup:extend "ParentPickup"

--- @param level Level
function ParentPickup:canPerform(level, item)
   return not prism.components.ParentController:is(self.owner:expect(prism.components.Controller))
end

return ParentPickup
