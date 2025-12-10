prism.Collision.assignNextAvailableMovetype("walk")
prism.Collision.assignNextAvailableMovetype("fly")

function prism.schedulers.SimpleScheduler:add(actor)
   self.nextQueue:push(actor)
end
