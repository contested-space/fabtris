require "block"

Piece = {}
Piece.__index = Piece

function Piece:new(piece_type)
   local obj = {}
   setmetatable(obj, Piece)

   obj.piece_type = piece_type

   obj.x = 5
   obj.y = 2
   obj:make_piece()


   

   return obj
end



function Piece:make_piece()

   if self.piece_type == "I" then
      mat = make_matrix(4, self.x, self.y)

      for i = 1, 4, 1 do
	 mat[i][2] = Block:new(self.x - 2 + i, self.y + 2, "I_block")
      end
      self.matrix = mat

   elseif piece_type == "J" then

   elseif piece_type == "L" then

   elseif piece_type == "O" then

   elseif piece_type == "S" then

   elseif piece_type == "T" then

   elseif piece_type == "Z" then
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
   if mat[4][1].target_x ~= grid_width - 1 then
      for i = 1, table.getn(self.matrix[1]), 1 do
	 for j = 1, table.getn(self.matrix[1]), 1 do
	    self.matrix[i][j]:move_right()
	 end
      end		       
   end
   
end
