--- @class LoseTarget : Action
local LoseTarget = prism.Action:extend "LoseTarget"
LoseTarget.requiredComponents = { prism.components.Alarm }

--- @param level Level
function LoseTarget:perform(level)
   self.owner:expect(prism.components.Alarm).target = nil
end

return LoseTarget
