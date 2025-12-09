--- @class Health : Component
--- @field maxHP integer
--- @field hp integer
local Health = prism.Component:extend("Health")

function Health:__new(maxHP)
   self.maxHP = maxHP
   self.hp = maxHP
end

--- @class HealthModifier : ConditionModifier
--- @field maxHP integer
local HealthModifier = prism.condition.ConditionModifier:extend "HealthModifier"

function HealthModifier:__new(delta)
   self.maxHP = delta
end

Health.Modifier = HealthModifier

return Health
