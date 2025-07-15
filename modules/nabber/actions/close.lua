--- @class Close : Action
local Close = prism.Action:extend("Close")
Close.targets = { prism.targets.DoorTarget() }

function Close:canPerform()
   return true
end

--- @param level Level
--- @param targetDoor Actor
function Close:perform(level, targetDoor)
   local door = targetDoor:expect(prism.components.Door)

   door.open = false
   targetDoor
      :give(door.closedDrawable)
      :give(prism.components.Collider())
      :give(prism.components.Opaque())

   if door.indicator then
      local position = targetDoor:getPosition() + door.indicator
      level:setCell(position.x, position.y, prism.cells.PipeDoorClosed())
   end
end

return Close
