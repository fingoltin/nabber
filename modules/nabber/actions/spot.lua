local anim = require "display.animation"
local palette = require "display.palette"
--- @class Spot : Action
local Spot = prism.Action:extend "Spot"
Spot.requiredComponents = { prism.components.Alarm, prism.components.Senses }
Spot.targets = {
   prism.Target(prism.components.Suspicious):isPrototype(prism.Actor):sensed(),
   prism.Target():isType("boolean"):optional(),
}

--- @param actor Actor
local animFactory = function(actor)
   return anim.newAnimation({
      function(display)
         local position = actor:expectPosition()
         display:put(position.x, position.y - 1, 34, palette[22], palette[6], 2)
      end,
   }, { 1 }, "pauseAtEnd")
end

--- @param level Level
--- @param actor Actor
--- @param force? boolean
function Spot:canPerform(level, actor, force)
   return force and true or self.owner:expect(prism.components.Alarm).target == nil
end

function Spot:perform(level, actor)
   self.owner:expect(prism.components.Alarm).target = actor
   level:yield(prism.messages.Animation(animFactory(self.owner)))
   level:yield(prism.messages.Interrupt())
end

return Spot
