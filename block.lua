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

function Block:fall(dt)
   if self.falling ~= true then
      self.target_y = self.target_y + 1
      self.falling = true
   end
end

function Block:move_left()
   if self.moving_left == false then
      self.target_x = self.target_x - 1
      self.moving_left = true
      self.moving_right = false
   end
end

function Block:move_right()
   if self.moving_right == false then
      self.target_x = self.target_x + 1
      self.moving_right = true
      self.moving_left = false
   end
end

function Block:update(dt)
   if self.moving_left then
      if self.target_x < self.x then
	 self.x = self.x - 10 * dt
      else
	 self:move_to(self.target_x, self.y)
	 self.moving_left = false
      end
   elseif self.moving_right then
      if self.target_x > self.x then
	 self.x = self.x + 10 * dt
      else
	 self:move_to(self.target_x, self.y)
	 self.moving_right = false
      end
   end

   if self.falling then
      if self.target_y > self.y then
	 self.y = self.y + dt * game_speed
      else
	 self.falling = false
      end

   end
end



function Block:draw(dt)
   if self.block_type ~= "null_block" then
      if self.block_type == "I_block" then
	 love.graphics.setColor(0.90, 0.69, 0.18)
      
      elseif self.block_type == "J_block" then
	 love.graphics.setColor(0.17, 0.58, 0.59)

      elseif self.block_type == "L_block" then
	 love.graphics.setColor(0.21, 0.81, 0.20)
      elseif self.block_type == "S_block" then
	 love.graphics.setColor(0.87, 0.82, 0.24)
      elseif self.block_type == "Z_block" then
	 love.graphics.setColor(0.98, 0.12, 0.04)
      elseif self.block_type == "T_block" then
	 love.graphics.setColor(0.79, 0.05, 0.31)
      elseif self.block_type == "O_block" then
	 love.graphics.setColor(0.56, 0.22, 0.52)
      end
	 

      
      love.graphics.rectangle("fill", self.x * block_size + self.offset,
	             		      self.y * block_size + self.offset,
         			      self.width, self.width)
      love.graphics.setColor(1, 1, 1)
   end
   
end

-- Colours looking more sober and serious

-- function Block:draw(dt)
--    if self.block_type ~= "null_block" then
--       if self.block_type == "I_block" then
-- 	 love.graphics.setColor(0.54, 0.73, 0.84)
      
--       elseif self.block_type == "J_block" then
-- 	 love.graphics.setColor(0.65, 0.48, 0.54)

--       elseif self.block_type == "L_block" then
-- 	 love.graphics.setColor(0.77, 0.31, 0.24)
--       elseif self.block_type == "S_block" then
-- 	 love.graphics.setColor(1, 0.91, 0.51)
--       elseif self.block_type == "Z_block" then
-- 	 love.graphics.setColor(0.89, 0.61, 0.38)
--       elseif self.block_type == "T_block" then
-- 	 love.graphics.setColor(0.77, 0.79, 0.42)
--       elseif self.block_type == "O_block" then
-- 	 love.graphics.setColor(0.54, 0.68, 0.34)
--       end
	 

      
--       love.graphics.rectangle("fill", self.x * block_size + self.offset,
-- 	             		      self.y * block_size + self.offset,
--          			      self.width, self.width)
--       love.graphics.setColor(1, 1, 1)
--    end

   
-- end



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


-- Summer's 80s palette
-- Hot Blue - 2deded
-- Colder Blue - 2c9596
-- Green - 36cf32
-- Yeller - dfd03c
-- Orange - e9982d
-- Red/Orange - ee5618
-- Hot Red - fa1e0a
-- Cooler(Blood) Red - b00103
-- Gotta have that Magenta, it's the 80's - c90d4f
-- Grape - 911752
-- Burple - 8f3885
