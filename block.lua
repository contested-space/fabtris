Block = {}
Block.__index = Block

function Block:new(x, y, speed)
   local obj = {}
   setmetatable(obj, Block)

   obj.x = x
   obj.y = y

   obj.target_x = x

   obj.moving_horizontaly = false
   obj.moving_left = false
   obj.moving_right = false

   obj.width = block_size
   obj.offset = 0
   obj.speed = speed

   return obj
   
end


function Block:update(dt)

   if self.moving_horizontaly then
      if self.target_x > self.x then
	 if self.moving_left then
	    self.moving_left = false
	    self.moving_horizontaly = false
	    self:move_to(self.target_x, self.y)
	 else
	    self.moving_right = true
	    self.x = self.x + 10 * dt
	 end
      elseif self.target_x < self.x then
	 if self.moving_right then
	    self.moving_right = false
	    self.moving_horizontaly = false
	    self:move_to(self.target_x, self.y)
	 else
	    self.moving_left = true
	    self.x = self.x - 10 * dt
	 end
      else
	 self.moving_horizontaly = false
	 self:move_to(self.target_x, self.y)
      end
   end
   self.y = self.y + dt * self.speed
   
   
end

function Block:draw(dt)
   love.graphics.rectangle("fill", self.x * block_size + self.offset,
			           self.y * block_size + self.offset,
				   self.width, self.width)

   
end


function Block:move_left()
   if self.moving_horizontaly == false then
      self.target_x = self.x - 1
      if self.target_x >= 0 then
	 self.moving_horizontaly = true
      elseif self.target_x < 0 then
	 self.target_x = 0
      end
      

   end
end


function Block:move_right()
   if self.moving_horizontaly == false then
      self.target_x = self.x + 1
      if self.target_x < grid_width then
	 self.moving_horizontaly = true
      elseif self.target_x > grid_width - 1 then
	 self.target_x = grid_width - 1
      end
      

   end
end


function Block:move_to(x, y)
   self.x = x
   self.y = y
end
