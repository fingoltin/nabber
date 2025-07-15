---@class AnimationMessage : Message
---@field animation Animation
local AnimationMessage = prism.Message:extend "AnimationMessage"

function AnimationMessage:__new(animation)
   self.animation = animation
end

return AnimationMessage
