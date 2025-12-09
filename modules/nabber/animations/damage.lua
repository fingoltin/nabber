local palette = require "display.palette"

spectrum.registerAnimation("Damage", function(actor)
   local drawable = actor:expect(prism.components.Drawable)
   return spectrum.Animation({
      { index = drawable.index, color = palette[22], background = drawable.background },
   }, 0.15, "pauseAtEnd")
end)

spectrum.registerAnimation("Projectile", function(owner, targetPosition)
   local x, y = owner:expectPosition():decompose()
   local line = prism.Bresenham(x, y, targetPosition.x, targetPosition.y)

   return spectrum.Animation(function(t, display)
      local index = math.floor(t / 0.5) + 1
      display:put(line[index][1], line[index][2], 158, palette[12], palette[6], 2)

      if index == #line then return true end

      return false
   end)
end)
