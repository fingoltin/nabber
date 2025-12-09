--- @class Reveal : Action
local Reveal = prism.Action:extend "Reveal"
Reveal.targets = { prism.Target():isVector2():range(1, "4way") }
Reveal.requiredComponents = {
   prism.components.Concealable,
   prism.components.Controller,
   prism.components.Equipper,
}

--- @param level Level
--- @param position Vector2
function Reveal:canPerform(level, position)
   local pilot = self.owner:expect(prism.components.Equipper):get("pilot")
   prism.logger.debug(pilot)
   if not pilot then return false end
   local mover = pilot:get(prism.components.Mover)
   prism.logger.debug(mover)
   if not mover then return false end

   return level:getCellPassable(position.x, position.y, mover.mask)
end

--- @param level Level
--- @param position Vector2
function Reveal:perform(level, position)
   local pilot = self.owner:expect(prism.components.Equipper):get("pilot")
   --- @cast pilot Actor

   self.owner:remove(prism.components.Controller)
   self.owner:remove(prism.components.Mover)
   self.owner:removeAllRelations(prism.relations.Piloted)

   pilot:give(prism.components.Position(position))
   level:addActor(pilot)
end

return Reveal
