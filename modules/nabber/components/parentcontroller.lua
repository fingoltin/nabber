--- @class ParentController : PlayerController
--- @field parent Actor the actor controlling this
--- @overload fun(parent): ParentController
local ParentController = prism.components.Controller:extend "ParentController"

function ParentController:__new(parent)
   self.parent = parent
end

function ParentController:decide(level, actor, decision)
   return prism.components.PlayerController.decide(self, level, actor, decision)
end

return ParentController
