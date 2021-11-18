PERMUTATIONS={}
SEEN={}

function heaps(k, array)
    if k == 1 then
      new = {}
      for _, v in ipairs(array) do
        table.insert(new, v)
      end
      key = table.concat(new,'\0')
      if not SEEN[key] then
        table.insert(PERMUTATIONS, new)
        SEEN[key] = true
      end
    else
        heaps(k-1, array)
        for i = 1, k do
            if k % 2 == 0 then
              array[k], array[i] = array[i], array[k]
            else
              array[k], array[1] = array[1], array[k]
            end
            heaps(k-1, array)
        end
    end
end

N = 8 -- board size

-- I let the program count the number of times it called printsolution
-- and it's 1048. The alternative implementation with all permutations
-- will be measured against that number.
-- Using Heap's algorithm I generate 12336 permutations, which is obviously
-- much worse than the previous approach.

-- check whether position (row, col) is free from attacks
function isplaceok(board, row, col)
  -- we can skip the last row because if all previous rows can't be attacked
  -- then the last one can't either
  for cur_row = 1, row - 1 do
    if (board[cur_row] == col) or                   -- same column?
       (board[cur_row] - cur_row == col - row) or   -- same diagonal?
       (board[cur_row] + cur_row == col + row) then -- same diagonal?
       return false                                 -- place can be attacked
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
end

-- check if the entire board is correct
function checkboard(board)
  for row = 1, N do
    col = board[row]
    if not isplaceok(board, row, col) then
      return false
    end
  end
  return true
end

board = {1,2,3,4,5,6,7,8}
heaps(8, board)
print(#PERMUTATIONS)

for _, perm in ipairs(PERMUTATIONS) do
  if checkboard(perm) then
    printsolution(perm)
    os.exit(0)
  end
end
