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
	    self.board[piece.matrix[i][j].target_x][piece.matrix[i][j].target_y] = piece.matrix[i][j]
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
   print(roll)
   if roll < 0.5 then
      return "J"
   else
      return "I"
   end
end

