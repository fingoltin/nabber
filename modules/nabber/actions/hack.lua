local palette = require "display.palette"
local HackTarget = prism.Target(prism.components.Hackable)

--- @class Hack : Action
local Hack = prism.Action:extend("Hack")
Hack.targets = { HackTarget }

--- @param level Level
function Hack:canPerform(level)
   return not self.owner:has(prism.components.ParentController)
end

--- @param level Level
--- @param hackableObject Actor
function Hack:perform(level, hackableObject)
   local hackable = hackableObject:expect(prism.components.Hackable)
   local drawable = hackableObject:expect(prism.components.Drawable)
   if hackable.on then
      drawable.color = palette[12]
   else
      drawable.color = palette[15]
   end
   level:query(prism.components.Door):each(function(door, c)
      if hackable.on then
         local open = prism.actions.Open(hackableObject, door)
         level:perform(open)
      else
         local close = prism.actions.Close(hackableObject, door)
         level:perform(close)
      end
   end)
   hackable.on = not hackable.on
end

return Hack
