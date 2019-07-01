require "piece"

Game = {}
Game.__index = Game

function Game:new()

   local obj = {}
   setmetatable(obj, Game)
   obj.board = make_board()
   obj.active_piece = Piece:new(random_piece())

   

   return obj
end

function Game:respawn()
   piece = self.active_piece
   for i = 1, piece.matrix_size, 1 do
      for j = 1, piece.matrix_size, 1 do
	 if piece.matrix[i][j].block_type ~= "null_block" then
	    --  self.board[piece.matrix[i][j].target_x + 1][piece.matrix[i][j].target_y] = piece.matrix[i][j]

	    --coord_x = math.floor(piece.matrix[i][j].x + 0.5 + 1)
	    --coord_y = math.floor(piece.matrix[i][j].y + 0.5 + 1)
--	    print("coords:")
	    coord_x = piece.matrix[i][j].target_x
	    coord_y = piece.matrix[i][j].target_y

--	    print(coord_x)
--	    print(coord_y)

	    if coord_x >= 0 and coord_y <= grid_height and coord_x <= grid_width then
	       self.board[coord_x + 1][coord_y] = piece.matrix[i][j]
--	       print(self.board[coord_x + 1][coord_y].block_type)
	    end
	 end	  
      end
   end
   self.active_piece = Piece:new(random_piece())
end

function Game:update(dt)
   if self.active_piece ~= nil then
      self.active_piece:update(dt)
   end

   for j = 1, grid_height do
      if self:check_line(j) then


	 self:clear_line(j)
      end
   end
   
end

function Game:draw(dt)
   for i = 1, grid_width, 1 do
      for j = 1, grid_height, 1 do
	 self.board[i][j]:draw()

      end
   end
   self.active_piece:draw(dt)
end

function Game:check(x, y)
   if x < 0 then
      --print("x < 1")
      return true
   elseif x > grid_width - 1 then
      --print("x > grid_width")
      return true
   elseif y < 1 then
      --print("y < 1")
      return true
   elseif y > grid_height then
      --print(x)
      --print(y)
      --print("y > grid_height ")
      return true
   elseif self.board[x+1][y].block_type ~= "null_block" then
      --print(x)
      --print(y)
      --print("block not nil!")
      return true
   end
   return false
end


function make_board()
   mat = {}
   for i = 1, grid_width, 1 do
      mat[i] = {}
      for j = 1, grid_height, 1 do
	 mat[i][j] = Block:new(i, j, "null_block")
	 mat[i][j]:stop()
      end
   end
   return mat
end

function random_piece()
   roll = math.random()
   if roll < 0.14 then
      return "J"
   elseif roll < 0.28 then
      return "L"
   elseif roll < 0.42 then
      return "I"
   elseif roll < 0.56 then
      return "O"
   elseif roll < 0.70 then
      return "S"
   elseif roll < 0.84 then
      return "Z"
   else
      return "T"
   end
  
end

function Game:clear_line(y)

   -- for i = 1, grid_width do
   --    self.board[i][y] = Block:new(i, y, "null_block")
   -- end
   for j = y, 2 , -1 do

      for i = 1, grid_width do

	 self.board[i][j-1]:translate(0, 1)
	 self.board[i][j] = self.board[i][j - 1]
      end
   end

   for i = 1, grid_width do
      self.board[i][1] = Block:new(i, 1, "null_block")
      
   end
end

function Game:check_line(y)
   total_block = 0
   for i = 1, grid_width do
      if self.board[i][y].block_type ~= "null_block" then
	 total_block = total_block + 1
      end
   end
   
   if total_block == grid_width then
      return true
   end
   return false
   
end


-- function random_piece()
--    roll = math.random()
--    if roll < 0.0 then
--       return "J"
--    elseif roll < 0.0 then
--       return "L"
--    elseif roll < 0.0 then
--       return "I"
--    elseif roll < 0.0 then
--       return "O"
--    elseif roll < 0.0 then
--       return "S"
--    elseif roll < 0.0 then
--       return "Z"
--    else
--       return "T"
--    end
  
-- end
