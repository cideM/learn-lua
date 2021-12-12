N = 8 -- board size

-- check whether position (n,c) is free from attacks
function isplaceok(board, n, col)
  for i = 1, n - 1 do                  -- for each queen already placed
    if (board[i] == col) or            -- same column?
       (board[i] - i == col - n) or    -- same diagonal?
       (board[i] + i == col + n) then  -- same diagonal?
       return false                    -- place can be attacked
     end
   end
   return true
end

-- print a board
function printsolution(board)
  for i = 1, N do   -- for each row
    for j = 1, N do -- and for each column
      -- write "X" or "-" plus a space
      io.write(board[i] == j and "X" or "-", " ")
    end
    io.write("\n")
  end
  io.write("\n")
  -- exit after printing the first solution
  os.exit(0)
end

-- add to board "board" all queens from "n" to "N"
function addqueen(board, n)
  if n > N then
    printsolution(board)
  else               -- try to place n-th queen
    for c = 1, N do
      if isplaceok(board, n, c) then
        board[n] = c -- place the n-th queen at column "c"
        addqueen(board, n + 1)
      end
    end
  end
end

-- run the program
addqueen({}, 1)

