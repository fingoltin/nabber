---@class SentryBehavior : BehaviorTree.Root
local SentryBehavior = prism.BehaviorTree.Root:extend("SentryBehavior")

local DIRECTIONS = {
   prism.Vector2.RIGHT,
   prism.Vector2.DOWN,
   prism.Vector2.LEFT,
   prism.Vector2.UP,
}

SentryBehavior.children = {
   prism.BehaviorTree.Sequence {
      -- Do we have a target?
      prism.BehaviorTree.Node(function(self, level, actor, controller)
         local alarm = actor:get(prism.components.Alarm)
         if alarm and alarm.target then
            if level:hasActor(alarm.target) then return true end
            return prism.actions.LoseTarget(actor)
         end
         return false
      end),
      prism.BehaviorTree.Node(function(self, level, actor, controller)
         local target = actor:expect(prism.components.Alarm).target
         --- @cast target Actor
         if actor:getPosition():getRange(target:getPosition()) == 1 then
            local attack = prism.actions.Attack(actor, target)
            return attack:canPerform(level) and attack
         end
         return true
      end),
      -- Otherwise try to move towards them
      prism.BehaviorTree.Node(function(self, level, actor, controller)
         local target = actor:get(prism.components.Alarm).target
         --- @cast target Actor
         if actor:getRange(target) < 2 then return prism.actions.Wait(actor) end
         local path = level:findPath(
            actor:getPosition(),
            target:getPosition(),
            actor,
            actor:get(prism.components.Mover).mask,
            1
         )
         if path then
            local move = prism.actions.Move(actor, path:pop())
            return level:canPerform(move) and move
         end

         return false
      end),
   },
   -- Finally, continue doing the rounds
   prism.BehaviorTree.Node(function(self, level, actor, controller)
      --- @cast controller SentryContoller
      local direction = controller.currentDirection
      local destination = actor:getPosition() + DIRECTIONS[direction]
      if
         not level:getCellPassable(
            destination.x,
            destination.y,
            actor:get(prism.components.Mover).mask
         )
      then
         direction = direction + 1
         if direction > 4 then direction = 1 end
         destination = actor:getPosition() + DIRECTIONS[direction]
         controller.currentDirection = direction
      end

      local move = prism.actions.Move(actor, destination)
      if level:canPerform(move) then
         return move
      else
         return prism.actions.Wait(actor)
      end
   end),
}

prism.behaviors.Sentry = SentryBehavior

return SentryBehavior
