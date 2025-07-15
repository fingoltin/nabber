--- @class Attack : Action
local Attack = prism.Action:extend "Attack"
Attack.targets = { prism.Target(prism.components.Health):isPrototype(prism.Actor) }

function Attack:canPerform()
   return true
end

--- Perform
---@param level Level
---@param target Actor
function Attack:perform(level, target)
   local health = target:expect(prism.components.Health)
   health.hp = health.hp - 1
   if health.hp <= 0 then
      local die = prism.actions.Die(target)
      level:perform(die)
   end
end

return Attack
