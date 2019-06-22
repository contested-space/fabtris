require "block"


function love.load()

   -- Game screen settings
   windowWidth = love.graphics.getWidth()
   windowHeight = love.graphics.getHeight()
   xscale = windowWidth / 330 -- TODO: find a way to declare that for love.conf at the same time
   yscale = windowHeight / 224

   -- Game grid settings


   grid_height = 24    -- Standard height is 20, add 4 for hidden starting blocks
   grid_width = 10


   -- initial setup: game takes the whole vertical space, aligned left of screen (someday center it)
   block_size = windowHeight / grid_height

   

   block = Block:new(2, 2, 2)

   -- Game initial states
   gameState = "intro"

end

function love.update(dt)

   block:update(dt)
   
   if love.keyboard.isDown("escape") then
      love.event.quit()
   end

   if love.keyboard.isDown("left") then
      block:move_to(block.x - 1, block.y)
   end

   
   if love.keyboard.isDown("right") then
      block:move_to(block.x + 1, block.y)
   end
   
end

function love.draw(dt)
   block:draw(dt)
end
