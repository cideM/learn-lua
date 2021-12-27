-- Write a function to shuffle a given list. Make sure that all permutations are equally probably.
-- Let's bring back Heap's algorithm from the eight queens puzzle! https://en.wikipedia.org/wiki/Heap%27s_algorithm

function heaps(k, array)
  local permutations, seen = {}, {}
  go = function(k, array)
    if k == 1 then
      local new = table.move(array, 1, #array, 1, {})
      local key = table.concat(new,'\0')
      if not seen[key] then
        table.insert(permutations, new)
        seen[key] = true
      end
    else
        go(k-1, array)
        for i = 1, k do
            if k % 2 == 0 then
              array[k], array[i] = array[i], array[k]
            else
              array[k], array[1] = array[1], array[k]
            end
            go(k-1, array)
        end
    end
  end
  go(k, array)

  return permutations
end

local permutations = heaps(4, {1,2,3,4})
for _, v in ipairs(permutations) do print(table.unpack(v)) end
