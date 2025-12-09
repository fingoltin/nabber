local palette = require "display.palette"
--- @class AnimationSystem : System
--- @field instances AnimationMessage[]
--- @field manuals (fun(dt: number): boolean)[]
local AnimationSystem = prism.System:extend "AnimationSystem"

function AnimationSystem:__new()
   self.instances = {}
   self.manuals = {}
end

function AnimationSystem:update(dt)
   for i = #self.instances, 1, -1 do
      local instance = self.instances[i]
      instance.animation:update(dt)
      if instance.animation.status == "paused" then table.remove(self.instances, i) end
   end

   for _, _, animation in
      self.owner:query(prism.components.Position, prism.components.IdleAnimation):iter()
   do
      --- @cast animation IdleAnimation
      animation.animation:update(dt)
   end
end

--- @param display Display
function AnimationSystem:draw(display)
   for actor, position, idleAnimation in
      self.owner:query(prism.components.Position, prism.components.IdleAnimation):iter()
   do
      --- @cast idleAnimation IdleAnimation
      --- @cast position Position
      local x, y = position:getVector():decompose()
      local animation = idleAnimation.animation

      animation:draw(display, x, y)
   end

   for _, instance in ipairs(self.instances) do
      local x, y = instance.x, instance.y
      if instance.actor then
         local position = instance.actor:expectPosition()
         x = x and x + position.x or position.x
         y = y and y + position.y or position.y
      end

      if not instance.actor or (instance.actor and instance.actor.level) then
         instance.animation:draw(display, x, y)
      end
   end

   for i = #self.manuals, 1, -1 do
      if self.manuals[i](love.timer.getDelta()) then table.remove(self.manuals, i) end
   end
end

function AnimationSystem:onYield(level, event)
   if prism.messages.Animation:is(event) then
      --- @cast event AnimationMessage
      if type(event.animation) == "function" then
         table.insert(self.manuals, event.animation)
      else
         table.insert(self.instances, event)
      end
   end
end

return AnimationSystem
