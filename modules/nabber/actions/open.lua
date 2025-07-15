--- @class Open : Action
local Open = prism.Action:extend("Open")
Open.targets = { prism.targets.DoorTarget() }

--- @param level Level
--- @param targetDoor Actor
function Open:canPerform(level, targetDoor)
   return not targetDoor:expect(prism.components.Door).open
end

--- @param level Level
--- @param targetDoor Actor
function Open:perform(level, targetDoor)
   local door = targetDoor:expect(prism.components.Door)

   door.open = true
   targetDoor
      :give(door.openDrawable)
      :remove(prism.components.Collider)
      :remove(prism.components.Opaque)

   if door.indicator then
      local position = targetDoor:getPosition() + door.indicator
      level:setCell(position.x, position.y, prism.cells.PipeDoorOpen())
   end
end

return Open
