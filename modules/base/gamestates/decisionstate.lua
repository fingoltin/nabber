--- @class DecisionState : GameState
--- @field previousState LevelState
local DecisionState = spectrum.GameState:extend "DecisionState"

function DecisionState:__new() end

function DecisionState:load(previous)
   --- @cast previous LevelState
   self.previousState = previous
end

function DecisionState:keypressed(key, scancode, isrepeat)
   self.manager:pop(key)
end

function DecisionState:draw()
   self.previousState:draw()
end

function DecisionState:update(dt)
   self.previousState:update(dt)
end

return DecisionState
