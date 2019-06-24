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

	    coord_x = math.floor(piece.matrix[i][j].x + 0.5 + 1)
	    coord_y = math.floor(piece.matrix[i][j].y + 0.5 + 1)
	    print("coord:")
	    print(coord_x)
	    print(coord_y)

	    if coord_x >= 1 and coord_y <= grid_height and coord_x <= grid_width then
	       self.board[coord_x][coord_y] = piece.matrix[i][j]
	       print(self.board[coord_x][coord_y].block_type)
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
   if x < 1 then
      return false
   elseif x > grid_width then
      return false
   elseif y < 1 then
      return false
   elseif y > grid_height then
      return false
   elseif self.board[x][y].block_type ~= "null_block" then
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
   if roll < 0.5 then
      return "J"
   else
      return "I"
   end
end

