local anim = require "display.animation"
local palette = require "display.palette"
--- @class Spot : Action
local Spot = prism.Action:extend "Spot"
Spot.requiredComponents = { prism.components.Alarm, prism.components.Senses }
Spot.targets = {
   prism.Target(prism.components.Suspicious):isPrototype(prism.Actor):sensed(),
   prism.Target():isType("boolean"):optional(),
}

--- @param level Level
--- @param actor Actor
--- @param force? boolean
function Spot:canPerform(level, actor, force)
   return force and true or self.owner:expect(prism.components.Alarm).target == nil
end

function Spot:perform(level, actor)
   self.owner:expect(prism.components.Alarm).target = actor
   level:yield(prism.messages.InterruptMessage())
   level:yield(prism.messages.AnimationMessage {
      animation = spectrum.animations.Exclamation(),
      actor = self.owner,
      y = -1,
      blocking = true,
   })
end

return Spot
