--- @class Hide : Action
local Hide = prism.Action:extend "Hide"
Hide.targets = { prism.Target(prism.components.Concealable):range(1) }

--- @param level Level
function Hide:canPerform(level, actor)
   return true
end

--- @param level Level
--- @param actor Actor
function Hide:perform(level, actor)
   actor:give(prism.components.Mover { "walk" })
   actor:give(prism.components.ParentController(self.owner))
   actor:give(prism.components.Senses())
   actor:give(prism.components.Sight { range = 1, fov = true })
   level:removeActor(self.owner)
end

return Hide
