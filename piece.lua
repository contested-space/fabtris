require "block"

Piece = {}
Piece.__index = Piece

function Piece:new(piece_type)
   local obj = {}
   setmetatable(obj, Piece)

   obj.piece_type = piece_type

   obj.is_rotating = false
   obj.rotation_duration = 0.1

   obj.x = 5
   obj.y = 0 
   obj.matrix_size = 0
   obj:make_piece()


   

   return obj
end



function Piece:make_piece()

   if self.piece_type == "I" then
      mat = make_matrix(4, self.x, self.y)
      self.matrix_size = 4

      for i = 1, 4, 1 do
	 mat[i][2] = Block:new(self.x - 2 + i, self.y + 2, "I_block")
      end
      self.matrix = mat

   elseif self.piece_type == "J" then
      mat = make_matrix(3, self.x, self.y)
      self.matrix_size = 3

      mat[1][1] = Block:new(self.x - 1, self.y - 1, "J_block")
      mat[1][2] = Block:new(self.x - 1, self.y, "J_block")
      mat[2][2] = Block:new(self.x , self.y, "J_block")
      mat[3][2] = Block:new(self.x + 1, self.y, "J_block")

      self.matrix = mat
      

   elseif self.piece_type == "L" then
      mat = make_matrix(3, self.x, self.y)
      self.matrix_size = 3

      mat[3][1] = Block:new(self.x + 1, self.y - 1, "L_block")
      mat[1][2] = Block:new(self.x - 1, self.y, "L_block")
      mat[2][2] = Block:new(self.x , self.y, "L_block")
      mat[3][2] = Block:new(self.x + 1, self.y, "L_block")

      self.matrix = mat
   elseif self.piece_type == "O" then
      mat = make_matrix(2, self.x, self.y)
      self.matrix_size = 2

      mat[1][1] = Block:new(self.x - 1, self.y - 1, "O_block")
      mat[1][2] = Block:new(self.x - 1, self.y, "O_block")
      mat[2][1] = Block:new(self.x, self.y - 1, "O_block")
      mat[2][2] = Block:new(self.x, self.y, "O_block")

      self.matrix = mat

   elseif self.piece_type == "S" then
      mat = make_matrix(3, self.x, self.y)
      self.matrix_size = 3

      mat[2][1] = Block:new(self.x, self.y - 1, "S_block")
      mat[3][1] = Block:new(self.x + 1, self.y - 1, "S_block")
      mat[1][2] = Block:new(self.x - 1 , self.y, "S_block")
      mat[2][2] = Block:new(self.x, self.y, "S_block")

      self.matrix = mat

   elseif self.piece_type == "T" then
      mat = make_matrix(3, self.x, self.y)
      self.matrix_size = 3

      mat[2][1] = Block:new(self.x, self.y - 1, "T_block")
      mat[1][2] = Block:new(self.x - 1, self.y, "T_block")
      mat[2][2] = Block:new(self.x , self.y, "T_block")
      mat[3][2] = Block:new(self.x + 1, self.y, "T_block")

      self.matrix = mat

      
      
   elseif self.piece_type == "Z" then
      mat = make_matrix(3, self.x, self.y)
      self.matrix_size = 3

      mat[1][1] = Block:new(self.x - 1, self.y - 1, "Z_block")
      mat[2][1] = Block:new(self.x , self.y - 1, "Z_block")
      mat[2][2] = Block:new(self.x , self.y, "Z_block")
      mat[3][2] = Block:new(self.x + 1, self.y, "Z_block")

      self.matrix = mat

   else
      error("invalid piece symbol")
   end
end

function make_matrix(n, x, y)
   mat = {}
   if n < 1 then
      error("invalid matrix size: " + n)
   else

      
      for i = 1, n, 1 do
	 mat[i] = {}
	 for j = 1, n, 1 do
	    mat[i][j] = Block:new(x - 2 + i, y - 2 + j, "null_block")
	 end
      end
   end
   return mat
end

function Piece:update(dt)
   
   if self:check_contact() ~= true then
      for i = 1, self.matrix_size, 1 do
	 for j = 1, self.matrix_size, 1 do
	    self.matrix[i][j]:update(dt)
	 end
	 
	 
      end
   end
end

function Piece:draw(dt)
   for i = 1, table.getn(self.matrix[1]), 1 do
      for j = 1, table.getn(self.matrix[1]), 1 do	 
	 mat[i][j]:draw(dt)
      end
   end
end


function Piece:move_left()
   left_blocks = self:get_leftmost_blocks()
   if check_left(left_blocks) == false then
      for i = 1, table.getn(self.matrix[1]), 1 do
	 for j = 1, table.getn(self.matrix[1]), 1 do
	    self.matrix[i][j]:move_left()
	 end
      end
   end
end

function Piece:move_right()
   right_blocks = self:get_rightmost_blocks()
   
   if check_right(right_blocks) == false then
      for i = 1, table.getn(self.matrix[1]), 1 do
	 for j = 1, table.getn(self.matrix[1]), 1 do
	    self.matrix[i][j]:move_right()
	 end
      end
   end
end


-- checks what's left of the leftmost blocks, returns false if there is nothing
function check_left(left_blocks)
   for k, v in pairs(left_blocks) do
      if v.target_x <= 0 then
	 return true
      elseif game:check(math.floor(v.x - 1), math.floor(v.y)) then
	 return true
      end
   end
   return false
end

function check_right(right_blocks)
   for k, v in pairs(right_blocks) do
      if v.target_x >= grid_width - 1 then
	 return true
      elseif game:check(math.floor(v.x + 1), math.floor(v.y)) then
	 return true
      end
   end
   return false
end


function Piece:get_leftmost_blocks()
   block_arr = {}
   for j = 1, self.matrix_size do
      found = false
      for i = 1, self.matrix_size do
	 if found == false then
	    if self.matrix[i][j].block_type ~= "null_block" then
	       table.insert(block_arr, self.matrix[i][j])
	       found = true
	    end
	 end
      end
   end
--   print(table.getn(block_arr))
   return block_arr
end

function Piece:get_rightmost_blocks()
   block_arr = {}
   for j = 1, self.matrix_size do
      found = false
      for i = self.matrix_size, 1, -1 do
	 if found == false then
	    if self.matrix[i][j].block_type ~= "null_block" then
	       table.insert(block_arr, self.matrix[i][j])
	       found = true
	    end
	 end
      end
   end
--   print(table.getn(block_arr))
   return block_arr
end

function Piece:get_lower_blocks()
   block_arr = {}
   for i = 1, self.matrix_size do
      found = false
      for j = self.matrix_size, 1, -1 do
	 if found == false then
	    if self.matrix[i][j].block_type ~= "null_block" then
	       table.insert(block_arr, self.matrix[i][j])
	       found = true
	    end
	 end	 
      end
   end
   return block_arr
end



-- function Piece:check_contact()

--    --Stop if it reaches bottom line or other blocks

--    for i = 1, self.matrix_size, 1 do
--       for j = 1, self.matrix_size, 1 do

-- 	 x = self.matrix[i][j].x
-- 	 y = self.matrix[i][j].y

-- 	 if x < 0 then


-- 	 elseif  x >= grid_width  then
	 
-- 	 elseif y <= 0 then

-- 	 else
	 
-- 	    if self.matrix[i][j].block_type ~= "null_block" and self.matrix[i][j].y >= grid_height - 1 then
-- 	       self:stop()
-- 	       return true
-- 	    elseif y > 1 and y < grid_height - 1  and x >= 1 and x < grid_width - 1 then


-- 	       if game:check(math.floor(x + 0.5), math.floor(y + 0.5) + 1) then
-- 		  self:stop()
-- 	       end
-- 	    end
-- 	 end
--       end
--    end
--       return false
-- end


function Piece:check_contact()
   lower_blocks = self:get_lower_blocks()
   
   contact = false
   
   for k, v in pairs(lower_blocks) do

      if v.target_y == grid_height then
	 contact = true

      elseif game:check(math.floor(v.x + 1), v.target_y + 1) then
	 contact = true
      end
   end

   if contact == true then
      self:stop()
   end
   return contact
   
end


function Piece:stop()
   for i = 1, self.matrix_size, 1 do
      for j = 1, self.matrix_size, 1 do
	 self.matrix[i][j]:stop()
      end
   end
   game:respawn()
end

function Piece:rotate_clockwise()
   if self.is_rotating == false then
      self.last_rotate = love.timer.getTime()
      self.is_rotating = true
      mat = {}
      for i = 1, self.matrix_size, 1 do
	 
	 mat[i] = {}
	 
      end

      for i = 1, self.matrix_size do
	 for j = 1, self.matrix_size do	    
	    mat[j][self.matrix_size - i + 1] = self.matrix[i][j]
	    self.matrix[i][j]:translate(j - i, self.matrix_size - i + 1 - j)
	 end
      end


      repeat

	 c_left = check_left(self:get_leftmost_blocks())
	 if c_left ~= false then
	    self:translate(1, 0)
	    
	 end
	 c_right= check_right(self:get_rightmost_blocks())
	 if c_right ~= false then
	    self:translate(-1, 0)
	 end
      until c_left == false and c_right == false
      
      self.matrix = mat
      
   elseif love.timer.getTime() - self.last_rotate > self.rotation_duration then
      self.is_rotating = false
   end
   
end

function Piece:translate(dx, dy)

   for i = 1, self.matrix_size do
      for j = 1, self.matrix_size do
	 self.matrix[i][j].x = self.matrix[i][j].x + dx
	 self.matrix[i][j].target_x = self.matrix[i][j].target_x + dx
	 
	 self.matrix[i][j].y = self.matrix[i][j].y + dy
	 self.matrix[i][j].target_y = self.matrix[i][j].target_y + dy
	 
      end
   end
   
end
