local palette = require "display.palette"
--- @class AnimationSystem : System
--- @field animations Animation[]
local AnimationSystem = prism.System:extend "AnimationSystem"

local anim = require "display.animation"

function AnimationSystem:__new()
   self.animations = {}
end

function AnimationSystem:update(dt)
   for i = #self.animations, 1, -1 do
      local animation = self.animations[i]
      animation:update(dt)
      if animation.status == "paused" then table.remove(self.animations, i) end
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

      animation.frames[animation.position](display, x, y)
   end

   for _, animation in ipairs(self.animations) do
      animation.frames[animation.position](display)
   end
end

function AnimationSystem:onYield(level, event)
   if prism.messages.Animation:is(event) then table.insert(self.animations, event.animation) end
end

return AnimationSystem
