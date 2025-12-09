--- @class AlarmSystem : System
local AlarmSystem = prism.System:extend("AlarmSystem")

function AlarmSystem:getRequirements()
   return prism.systems.Senses, prism.systems.Sight
end

---@param level Level
---@param actor Actor
function AlarmSystem:onMove(level, actor, from, to)
   -- A suspicious actor moved
   if actor:has(prism.components.Suspicious) then
      for alarm, _, senses in level:query(prism.components.Alarm, prism.components.Senses):iter() do
         -- We want to update what the alarm sees before it moves.
         level:getSystem(prism.systems.SensesSystem):triggerRebuild(level, alarm)
         --- @cast senses Senses
         if alarm:hasRelation(prism.relations.SensesRelation, actor) then
            local action = prism.actions.Spot(alarm, actor)
            if level:canPerform(action) then level:perform(action) end
         end
      end
   -- An alarm moved. Suspicious actors with onlyWhenMoving are not spotted.
   elseif actor:has(prism.components.Alarm) then
      level:getSystem(prism.systems.SensesSystem):triggerRebuild(level, actor)

      local senses = actor:get(prism.components.Senses)
      if not senses then return end

      for other, suspicious in senses:query(level, prism.components.Suspicious):iter() do
         --- @cast suspicious Suspicious
         print(suspicious.onlyWhenMoving)
         if not suspicious.onlyWhenMoving then
            local action = prism.actions.Spot(actor, other)
            if level:canPerform(action) then level:perform(action) end
         end
      end
   end
end

function AlarmSystem:afterAction(level, actor, action)
   if not prism.actions.Hide:is(action) then return end

   --- @cast action Hide
   for sentry, alarm in level:query(prism.components.Alarm):iter() do
      --- @cast alarm Alarm
      if alarm.target == actor then
         local spot = prism.actions.Spot(sentry, action:getTarget(1), true)
         local can, error = level:canPerform(spot)
         if can then level:perform(spot) end
      end
   end
end

return AlarmSystem
