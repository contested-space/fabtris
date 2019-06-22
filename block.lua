Block = {}
Block.__index = Block

function Block:new(x, y, speed)
   local obj = {}
   setmetatable(obj, Block)

   obj.x = x
   obj.y = y

   obj.width = block_size
   obj.offset = 0
   obj.speed = speed

   return obj
   
end


function Block:update(dt)
   self.y = self.y + dt * self.speed
   

   
end

function Block:draw(dt)
   love.graphics.rectangle("fill", self.x * block_size + self.offset,
			           self.y * block_size + self.offset,
				   self.width, self.width)

   
end


function Block:move_to(x, y)
   self.x = x
   self.y = y
end
