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
   obj.y = 2
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
   self:check_contact()
   for i = 1, table.getn(self.matrix[1]), 1 do
      for j = 1, table.getn(self.matrix[1]), 1 do
	 mat[i][j]:update(dt)
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
   if mat[1][1].target_x ~= 0 then
      for i = 1, table.getn(self.matrix[1]), 1 do
	 for j = 1, table.getn(self.matrix[1]), 1 do
	    self.matrix[i][j]:move_left()
	 end
	 
      end
   end
end


function Piece:move_right()
   if mat[self.matrix_size][1].target_x ~= grid_width - 1 then
      for i = 1, table.getn(self.matrix[1]), 1 do
	 for j = 1, table.getn(self.matrix[1]), 1 do
	    self.matrix[i][j]:move_right()
	 end
      end		       
   end
   
end

function Piece:check_contact()

   --Stop if it reaches bottom line
   if self.matrix[1][self.matrix_size].y >= grid_height - 1 then
      for i = 1, self.matrix_size, 1 do
	 for j = 1, self.matrix_size, 1 do
	    self.matrix[i][j]:stop()
	 end
      end
   end
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

