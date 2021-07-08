GameArea = {}
GameArea.__index = GameArea

function GameArea:new()
   local obj = {}
   setmetatable(obj, GameArea)
   return obj
end

function GameArea:update(dt)
end

function GameArea:draw(dt)
   love.graphics.setColor(0.18, 0.93, 0.93)
   for i = 0, grid_width, 1 do
      love.graphics.line(i * block_size, 0, i * block_size, grid_height * block_size)
   end

   for j = 0, grid_height, 1 do
      love.graphics.line(0, j * block_size, grid_width * block_size, j * block_size)
   end
   love.graphics.setColor(1, 1, 1)
end
