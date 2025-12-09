--- @class Die : Action
local Die = prism.Action:extend "Die"
Die.targets = {}

--- @param level Level
function Die:canPerform(level)
   return true
end

--- @param level Level
function Die:perform(level)
   local drops = self.owner:get(prism.components.Drops)

   if drops then
      local droppedActor = drops.actoryFactory()
      droppedActor:give(prism.components.Position(self.owner:getPosition()))
      level:addActor(droppedActor)
   end

   if self.owner:hasRelation(prism.relations.Piloted) then
      local pilot = self.owner:getRelation(prism.relations.Piloted)
      pilot:give(prism.components.Position(self.owner:getPosition()))
      level:addActor(pilot)
   end

   level:removeActor(self.owner)
end

return Die
