--- @diagnostic disable-next-line
function love.conf(t)
   t.window.vsync = 0 -- Enable vsync (1 by default)
   -- t.window.width = 1248
   t.window.width = 1600
   t.window.height = 900
   t.window.fullscreen = false
   t.window.title = "nabber!"
   -- Other configurations...
end
