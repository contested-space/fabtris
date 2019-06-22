Block = {}
Block.__index = Block

function Block:new(x, y)
   local obj = {}
   setmetatable(obj, Block)

   obj.x = x
   obj.y = y

   obj.width = block_size
   obj.offset = 0

   return obj
   
end


function Block:update(dt)

end

function Block:draw(dt)
   love.graphics.rectangle("fill", self.x * block_size + self.offset,
			           self.y * block_size + self.offset,
				   self.width, self.width)

   
end
