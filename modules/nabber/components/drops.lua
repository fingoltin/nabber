--- @class Drops : Component
--- @field actoryFactory ActorFactory
--- @overload fun(actorFactory: ActorFactory): Drops
local Drops = prism.Component:extend "Drops"

function Drops:__new(actorFactory)
   self.actoryFactory = actorFactory
end

return Drops
