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

   elseif self.piece_type == "O" then

   elseif self.piece_type == "S" then

   elseif self.piece_type == "T" then

   elseif self.piece_type == "Z" then
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
	    mat[i][j]:update(dt)
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
      end
   end
   return false
end

function check_right(right_blocks)
   for k, v in pairs(right_blocks) do
      if v.target_x >= grid_width - 1 then
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




function Piece:check_contact()

   --Stop if it reaches bottom line

   for i = 1, self.matrix_size, 1 do
      for j = 1, self.matrix_size, 1 do	 
	 if self.matrix[i][j].block_type ~= "null_block" and self.matrix[i][j].y >= grid_height - 1 then
	    self:stop()
	    return true
	 end
      end
   end
   return false
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

      self.matrix = mat
      
   elseif love.timer.getTime() - self.last_rotate > self.rotation_duration then
      self.is_rotating = false
   end
   
end

