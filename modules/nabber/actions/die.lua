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

   local parent = self.owner:get(prism.components.ParentController)
   if parent then
      local parentActor = parent.parent
      parentActor:give(prism.components.Position(self.owner:getPosition()))
      level:addActor(parentActor)
   end

   level:removeActor(self.owner)
end

return Die
