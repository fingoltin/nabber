--- @class Attack : Action
local Attack = prism.Action:extend "Attack"
Attack.requiredComponents = { prism.components.C }
Attack.targets = { prism.Target(prism.components.Health):isPrototype(prism.Actor) }

function Attack:canPerform()
   return not prism.components.ParentController:is(self.owner:expect(prism.components.Controller))
end

---@param level Level
---@param target Actor
function Attack:perform(level, target)
   local health = target:expect(prism.components.Health)
   health.hp = health.hp - 1
   level:yield(prism.messages.AnimationMessage {
      animation = spectrum.animations.Damage(target),
      actor = target,
      blocking = true,
   })
   level:yield(prism.messages.InterruptMessage())

   if health.hp <= 0 then
      local die = prism.actions.Die(target)
      level:perform(die)
   end
end

return Attack
