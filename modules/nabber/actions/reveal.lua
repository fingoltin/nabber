--- @class Reveal : Action
local Reveal = prism.Action:extend "Reveal"
Reveal.targets = { prism.Target():isPrototype(prism.Vector2) }
Reveal.requiredComponents = { prism.components.ParentController }

--- @param level Level
--- @param direction Vector2
function Reveal:canPerform(level, direction)
   local child = self.owner:expect(prism.components.ParentController).parent
   local mover = child:get(prism.components.Mover)
   if not mover then return false end

   local position = self.owner:getPosition() + direction

   return level:getCellPassable(position.x, position.y, mover.mask)
end

--- @param level Level
function Reveal:perform(level, direction)
   local child = self.owner:expect(prism.components.ParentController).parent
   local position = self.owner:getPosition() + direction

   self.owner:remove(prism.components.ParentController)
   self.owner:remove(prism.components.Mover)

   child:give(prism.components.Position(position))
   level:addActor(child)
end

return Reveal
