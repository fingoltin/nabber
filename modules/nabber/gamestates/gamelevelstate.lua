local controls = require "controls"
local palette = require "display.palette"

--- @class GameLevelState : LevelState
--- A custom game level state responsible for initializing the level map,
--- handling input, and drawing the state to the screen.
---
--- @field path Path
--- @field level Level
--- @overload fun(display: Display, overlay: Display): GameLevelState
local GameLevelState = spectrum.gamestates.LevelState:extend "GameLevelState"

--- @param display Display
--- @param overlay Display
function GameLevelState:__new(display, overlay)
   self.background = 17
   -- Construct a simple test map using MapBuilder.
   -- In a complete game, you'd likely extract this logic to a separate module
   -- and pass in an existing player object between levels.
   local builder = require("generate.generate")(
      prism.RNG(love.math.getRandomSeed()),
      prism.actors.Player(),
      33,
      18
   )

   -- Place the player character at a starting location
   -- mapbuilder:addPadding(1, prism.cells.Pit)

   -- Build the map and instantiate the level with systems
   builder:addSystems(
      prism.systems.SensesSystem(),
      prism.systems.SightSystem(),
      prism.systems.AutoTileSystem(),
      prism.systems.AlarmSystem()
   )

   self.overlay = overlay

   -- Initialize with the created level and display, the heavy lifting is done by
   -- the parent class.
   self.super.__new(self, builder:build(prism.cells.Pit), display)

   self.alarmQuery = self.level:query(prism.components.Alarm, prism.components.Senses)
   self.mouseActive = false
end

function GameLevelState:handleMessage(message)
   self.super.handleMessage(self, message)

   if prism.messages.InterruptMessage:is(message) then
      self.selectedPath = nil
      self.path = nil
   end
end

local timer = 0.1
function GameLevelState:updateDecision(dt, owner, decision)
   controls:update()
   -- if key == "right" then
   --    self.background = self.background + 1
   --    if self.background >= #palette then self.background = 1 end
   --    love.graphics.setBackgroundColor(palette[self.background]:decompose())
   --    return
   -- elseif key == "left" then
   --    self.background = self.background - 1
   --    if self.background <= 1 then self.background = #palette end
   --    love.graphics.setBackgroundColor(palette[self.background]:decompose())
   --    return
   -- end
   local x, y, cell = self:getCellUnderMouse()
   if self.mouseActive and cell and not self.selectedPath then
      local path = nil
      local minDistance = 0
      while not path and minDistance < 32 do
         path = self.level:findPath(
            owner:getPosition(),
            prism.Vector2(x, y),
            owner,
            owner:expect(prism.components.Mover).mask,
            minDistance
         )
         minDistance = minDistance + 1
      end
      self.path = path
   else
      self.path = nil
   end

   timer = timer - dt
   if self.selectedPath and self.selectedPath:length() > 0 and timer <= 0 then
      local position = self.selectedPath:pop()
      local action = self:performOn(position, position - owner:getPosition(), owner)
      if action then self.decision:setAction(action, self.level) end
      if self.selectedPath:length() == 0 then self.selectedPath = nil end
      timer = 0.05
   end

   if self.selectedPath then return end

   if controls.select_path.pressed then
      if cell and self.path then
         self.mouseActive = false
         self.selectedPath = self.path
         print("hey man")
      end
      return
   end

   if controls.restart.pressed then love.event.restart() end

   if controls.move.pressed then
      local destination = owner:getPosition() + controls.move.vector
      local toPerform = self:performOn(destination, controls.move.vector, owner)
      if toPerform then
         self:setAction(toPerform)
         return
      end
   end

   if controls.pickup.pressed then
      local actor =
         self.level:query(prism.components.Item):at(owner:getPosition():decompose()):first()
      local pickup = prism.actions.ParentPickup(owner, actor)
      if self:setAction(pickup) then return end
   end

   if controls.wait.pressed then
      self:setAction(prism.actions.Wait(owner))
      return
   end

   if controls.hide.pressed then
      self.targets = {}
      if owner:hasRelation(prism.relations.Piloted) then
         self.selectedAction = prism.actions.Reveal
      else
         self.selectedAction = prism.actions.Hide
      end
      self.manager:push(
         spectrum.gamestates.GeneralTargetHandler(
            self.overlay,
            self,
            self.targets,
            self.selectedAction:getTarget(1)
         )
      )
      -- for actor in self.level:query(prism.components.Concealable):iter() do
      --    if prism.actions.Hide:validateTarget(1, self.level, owner, actor) then
      --       decision:setAction(prism.actions.Hide(owner, actor))
      --    end
      -- end
   end
end

function GameLevelState:focus(focus)
   self.path = nil
   self.selectedPath = nil
end

function GameLevelState:transformMousePosition(mx, my)
   return (mx / 2) - 16, (my / 2) - 16
end

--- @param vector? Vector2
local function directionToArrow(vector)
   if vector == prism.Vector2.UP then return 29 end
   if vector == prism.Vector2.DOWN then return 30 end
   if vector == prism.Vector2.RIGHT then return 31 end
   if vector == prism.Vector2.LEFT then return 32 end
   return nil
end

local walk = prism.Collision.createBitmaskFromMovetypes({ "walk" })

function GameLevelState:putOverlay()
   self.overlay:put(24, 23, 162, palette[6], palette[self.background])
   self.overlay:line(25, 23, 32, 23, 1, nil, palette[6])
   self.overlay:put(23, 23, 1, palette[6], palette[6])
   self.overlay:put(33, 23, 163, palette[6], palette[self.background])
   self.overlay:put(32, 23, 155, palette[22], palette[6])
   local x, y, cell = self:getCellUnderMouse()
   if self.mouseActive and cell then
      self.overlay:beginCamera()
      self.overlay:put(x, y, 155, palette[22])
      --- @type Entity
      local entity = cell
      local actor = self.level:query():at(x, y):first()
      if actor then entity = actor end
      self.overlay:putDrawable(23, 23, entity:expect(prism.components.Drawable))
      self.overlay:print(25, 23, entity:getName(), palette[22], palette[6], 2)
      self.overlay:endCamera()
   end

   self.overlay:beginCamera()

   local player = self.level:query(prism.components.PlayerController):first()
   local pilot = player:getRelation(prism.relations.Piloted)

   self.overlay:put(23, 25, 1, palette[6], palette[6])
   self.overlay:put(24, 25, 162, palette[6], palette[self.background])
   self.overlay:line(25, 25, 32, 25, 1, nil, palette[6])
   self.overlay:put(32, 25, 30, palette[20], palette[6], 1)
   self.overlay:put(33, 25, 163, palette[6], palette[self.background])
   --- @type Actor?
   local actorAt
   self.level:query():at(player:getPosition():decompose()):each(function(actor)
      if actor ~= player then actorAt = actor end
   end)
   if actorAt then
      self.overlay:putDrawable(23, 25, actorAt:expect(prism.components.Drawable))
      self.overlay:print(25, 25, actorAt:getName(), palette[22], palette[6], 2)
   end

   local health = player:expect(prism.components.Health).hp
   local pilotHealth = pilot and pilot:expect(prism.components.Health).hp or health
   --(
   self.overlay:put(3, 23, 162, palette[6], palette[self.background])
   self.overlay:line(4, 23, 6, 23, 283, palette[14], palette[6])
   if pilotHealth >= 1 then self.overlay:put(4, 23, 284, palette[14], palette[6]) end
   if pilotHealth >= 2 then self.overlay:put(4, 23, 282, palette[14], palette[6]) end
   if pilotHealth >= 3 then self.overlay:put(5, 23, 284, palette[14], palette[6]) end
   if pilotHealth >= 4 then self.overlay:put(5, 23, 282, palette[14], palette[6]) end
   if pilotHealth >= 5 then self.overlay:put(6, 23, 284, palette[14], palette[6]) end
   if pilotHealth >= 6 then self.overlay:put(6, 23, 282, palette[14], palette[6]) end
   if pilot then
      if health >= 1 then self.overlay:put(4, 23, 284, palette[26], palette[6]) end
      if health >= 2 then self.overlay:put(4, 23, 282, palette[26], palette[6]) end
      if health >= 3 then self.overlay:put(5, 23, 284, palette[26], palette[6]) end
      if health >= 4 then self.overlay:put(5, 23, 282, palette[26], palette[6]) end
      if health >= 5 then self.overlay:put(6, 23, 284, palette[26], palette[6]) end
      if health >= 6 then self.overlay:put(6, 23, 282, palette[26], palette[6]) end
   end
   self.overlay:put(7, 23, 163, palette[6], palette[self.background])

   --coin
   self.overlay:put(9, 23, 143, palette[12], palette[6])
   --(
   self.overlay:put(10, 23, 162, palette[6], palette[self.background])
   --0
   self.overlay:put(11, 23, 49, palette[22], palette[6])
   self.overlay:put(12, 23, 49, palette[22], palette[6])
   --0
   self.overlay:put(13, 23, 163, palette[6], palette[self.background])
   --)
   local inventory = player:expect(prism.components.Inventory)
   local coin = inventory:getStack("coin")
   local count = coin and coin:expect(prism.components.Item).stackCount or 0
   self.overlay:put(12, 23, 49 + count, palette[22], palette[6])

   self.overlay:print(15, 23, "SHFT")
   self.overlay:print(15, 25, "CTRL")
   self.overlay:put(19, 23, 162, palette[6], palette[self.background])
   self.overlay:put(20, 23, 32, palette[controls.pull.down and 20 or 7], palette[6])
   self.overlay:put(21, 23, 163, palette[6], palette[self.background])

   self.overlay:put(19, 25, 162, palette[6], palette[self.background])
   self.overlay:put(20, 25, 355, palette[controls.attack.down and 10 or 8], palette[6])
   self.overlay:put(21, 25, 163, palette[6], palette[self.background])
end

local leftBorder = love.graphics.newImage("display/left-border.png")
local rightBorder = love.graphics.newImage("display/right-border.png")

function GameLevelState:draw()
   self.overlay:clear()
   self.display:clear()

   -- self.display:setCamera(2, 2)
   -- self.overlay:setCamera(2, 2)

   local primary, secondary = self:getSenses()
   local primarySenses = primary[1]
   -- Render the level using the actor’s senses
   self.display:putLevel(self.level)

   self.display:beginCamera()

   for x, y, cell in primary[1].cells:each() do
      ---@cast cell Cell
      local seen = cell:get(prism.components.Seen)
      if seen then self.display:putDrawable(x, y, seen.drawable, seen.drawable.color) end
   end

   for _, alarm, senses in self.alarmQuery:iter() do
      --- @cast alarm Alarm
      --- @cast senses Senses
      if not alarm.target then
         for x, y, cell in senses.cells:each() do
            --- @cast cell Cell
            if self.level:getCellPassable(x, y, walk) then
               local char = self.display.cells[x][y]
               self.display:put(x, y, char.char, palette[28], char.bg, 1)
            end
         end
      end
   end

   -- Handle darkness, i.e. pipes.
   for actor, position in self.level:query(prism.components.Position):iter() do
      --- @cast position Position

      local position = position:getVector()
      local cell = self.level:getCell(position:decompose())

      -- In the dark and we can see it
      if
         cell:has(prism.components.Dark)
         and primarySenses.owner:hasRelation(prism.relations.SensesRelation, actor)
      then
         local drawable = actor:expect(prism.components.Drawable)
         self.display:putDrawable(position.x, position.y, drawable, palette[18])
      -- In the dark but we can't see it
      elseif cell:has(prism.components.Dark) then
         self.display:putDrawable(
            position.x,
            position.y,
            cell:expect(prism.components.Drawable),
            nil,
            3
         )
      end
   end

   -- self.animationSystem:draw(self.display)

   if self.path then self:drawPath() end
   self.display:endCamera()
   -- local move = prism.actions.Move(owner, prism.Vector2(x, y))
   -- if cell and self.level:canPerform(move) then
   --    self.display.cells[x + dx][y + dy].fg = palette[20]:copy()
   -- end

   self:putOverlay()
   self.display:putAnimations(self.level)

   love.graphics.translate(32, 32)
   love.graphics.scale(2, 2)
   self.display:draw()
   self.overlay:draw()
   love.graphics.translate(-16, -16)

   love.graphics.setColor(love.graphics.getBackgroundColor())
   love.graphics.draw(leftBorder, 8, 8)
   love.graphics.draw(rightBorder, 288, 8)
   love.graphics.setColor(1, 1, 1, 1)
end

function GameLevelState:drawPath()
   local player = self:getCurrentActor()
   if not player then return end

   for _, position in ipairs(self.path:getPath()) do
      local cell = self.level:getCell(position:decompose())
      local senses = player:expect(prism.components.Senses)
      if cell:has(prism.components.Dark) and not senses.cells:get(position:decompose()) then
      else
         self.display.cells[position.x + self.display.camera.x][position.y + self.display.camera.y].fg =
            palette[20]:copy()
      end
   end
end

function GameLevelState:mousemoved(x, y, dx, dy, istouch)
   self.mouseActive = true
end

--- @param position Vector2
--- @param direction Vector2
--- @param owner Actor
--- @return Action?
function GameLevelState:performOn(position, direction, owner)
   self.mouseActive = false

   if controls.pull.down then
      local actorPosition = (direction * -1) + owner:getPosition()
      local actor =
         self.level:query(prism.components.Pushable):at(actorPosition:decompose()):first()
      local pull = prism.actions.Pull(owner, actor, direction)
      if self.level:canPerform(pull) then return pull end
   end

   local collidable = self.level:query(prism.components.Collider):at(position:decompose()):first()

   if controls.attack.down then
      local attack = prism.actions.Attack(owner, collidable)
      if self.level:canPerform(attack) then return attack end
   end

   local move = prism.actions.Move(owner, position)
   if self.level:canPerform(move) then return move end

   local push = prism.actions.Push(owner, collidable, direction)
   local can, err = self.level:canPerform(push)
   if can then return push end

   if collidable and not collidable:has(prism.components.Pushable) then
      local attack = prism.actions.Attack(owner, collidable)
      if self.level:canPerform(attack) then return attack end
   end
end

function GameLevelState:resume()
   local sensesSystem = self.level:getSystem(prism.systems.SensesSystem)
   if sensesSystem then sensesSystem:postInitialize(self.level) end

   local autotileSystem = self.level:getSystem(prism.systems.AutoTileSystem)
   if autotileSystem then autotileSystem:initialize(self.level) end

   if self.targets then
      local action = self.selectedAction(self.decision.actor, unpack(self.targets))
      local success, err = self:setAction(action)
      if not success then prism.logger.info(err) end
      self.targets = nil
   end
end

return GameLevelState
