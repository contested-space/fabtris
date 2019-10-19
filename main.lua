require "block"
require "game_area"
require "piece"
require "game"


function love.load()

   -- Game screen settings
   windowWidth = love.graphics.getWidth()
   windowHeight = love.graphics.getHeight()
   xscale = windowWidth / 330 -- TODO: find a way to declare that for love.conf at the same time
   yscale = windowHeight / 224

   -- Game grid settings


   grid_height = 20    -- Standard height is 20, add 4 for hidden starting blocks
   grid_width = 10


   -- initial setup: game takes the whole vertical space, aligned left of screen (someday center it)
   block_size = windowHeight / grid_height

   
   area = GameArea:new()
--   block = Block:new(2, 2)

--   piece = Piece:new("J")

   -- Game initial states

   initial_game_speed = 4
   level = 1

   game_speed = initial_game_speed 
   
   game = Game:new()
   
   gameState = "playing"

end

function love.update(dt)

--   block:update(dt)
   game:update(dt)
   
   if love.keyboard.isDown("escape") then
      love.event.quit()
   end

   if love.keyboard.isDown("left") then
      game.active_piece:move_left()
   end

   
   if love.keyboard.isDown("right") then
      game.active_piece:move_right()
   end

   
   if love.keyboard.isDown("up") then
      game.active_piece:rotate_clockwise()
   end
   
end

function love.draw(dt)
   area:draw(dt)
--   block:draw(dt)
   game:draw(dt)
end
