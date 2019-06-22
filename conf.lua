require "settings"

function love.conf(t)
   s = settings()

   t.version = "11.2"
   t.window.width = s.window.x
   t.window.height = s.window.y
   t.window.title = "fabtris"
   t.window.fullscreen = true
end
