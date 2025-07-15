--- @class ParentController : PlayerController
--- @field parent Actor the actor controlling this
--- @overload fun(parent): ParentController
local ParentController = prism.components.Controller:extend "ParentController"

function ParentController:__new(parent)
   self.parent = parent
end

function ParentController:act(level, actor)
   return prism.components.PlayerController.act(self, level, actor)
end

return ParentController
