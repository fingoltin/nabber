--- @class Hide : Action
local Hide = prism.Action:extend "Hide"
Hide.targets = { prism.Target(prism.components.Concealable, prism.components.Equipper):range(1) }

--- @param level Level
--- @param actor Actor
function Hide:canPerform(level, actor)
   return actor:expect(prism.components.Equipper):canEquip(self.owner)
end

--- @param level Level
--- @param actor Actor
function Hide:perform(level, actor)
   actor:give(prism.components.Mover { "walk" })
   actor:give(prism.components.PlayerController())
   actor:give(prism.components.Senses())
   actor:give(prism.components.Sight { range = 1, fov = true })
   level:removeActor(self.owner)
   actor:addRelation(prism.relations.Piloted, self.owner)
   level:perform(prism.actions.Equip(actor, self.owner))
end

return Hide
