Block = {}
Block.__index = Block

function Block:new(x, y, block_type)
   local obj = {}
   setmetatable(obj, Block)

   obj.x = x
   obj.y = y

   obj.block_type = block_type
   
   obj.target_x = x
   obj.target_y = y + 1

   obj.moving_horizontaly = false
   obj.moving_left = false
   obj.moving_right = false

   obj.width = block_size
   obj.offset = 0
   obj.speed = game_speed

   self.stopped = false
   return obj
   
end


function Block:update(dt)
   if self.stopped ~= true then
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
      self.y = self.y + dt * game_speed

      if self.y >= self.target_y then
	 self.target_y = self.target_y + 1
      end
      
   end
end

function Block:draw(dt)
   if self.block_type ~= "null_block" then
      if self.block_type == "I_block" then
	 love.graphics.setColor(0, 1, 1)
      
      elseif self.block_type == "J_block" then
	 love.graphics.setColor(0, 0, 1)

      elseif self.block_type == "L_block" then
	 love.graphics.setColor(1, 0.5, 0)
      elseif self.block_type == "S_block" then
	 love.graphics.setColor(1, 1, 0)
      elseif self.block_type == "Z_block" then
	 love.graphics.setColor(0.5, 0, 0.5)
      elseif self.block_type == "T_block" then
	 love.graphics.setColor(1, 1, 0)
      elseif self.block_type == "O_block" then
	 love.graphics.setColor(1, 0, 0)
      end
	 

      
      love.graphics.rectangle("fill", self.x * block_size + self.offset,
	             		      self.y * block_size + self.offset,
         			      self.width, self.width)
      love.graphics.setColor(1, 1, 1)
   end

   
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

function Block:stop()

   self.stopped = true

   self:move_to(self.target_x, self.target_y -1)

end

function Block:translate(x, y)   
   self.x = self.x + x
   self.y = self.y + y
   self.target_x = self.target_x + x
   self.target_y = self.target_y + y
end
