local SentryBehavior = require "modules.nabber.behaviortrees.sentrytree"
--- @class SentryContoller : Controller
--- @field currentDirection integer
--- @field rootNode BehaviorTree.Root
local SentryContoller = prism.components.Controller:extend "SentryContoller"

function SentryContoller:__new(startingDirection)
   self.currentDirection = startingDirection or 2
   self.rootNode = SentryBehavior
end

function SentryContoller:getRequirements()
   return prism.components.Mover
end

---@param level Level
---@param actor Actor
function SentryContoller:act(level, actor)
   return self.rootNode:run(level, actor, self)
end

return SentryContoller
