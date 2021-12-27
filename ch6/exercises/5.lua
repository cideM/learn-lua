-- 6.5 Write a function that takes an array and prints all combinations of the
--   elements in the array.
--   Hint: you can use the recursive formula for combination:
--   C(n,m) = C(n-1,m-1)+C(n-1,m)
--   To generate all C(n,m) combinations of n elements in groups of size m, you
--   first add the first element to the result, and then generate all
--   C(n-1,m-1) combinations of the remaining elements in the remaining slots;
--   then you remove the first element from the result and then generate all
--   C(n-1,m) combinations of the remaining elements in the free slots. When n
--   is smaller than m, there are no combinations. When m is zero, there is
--   only one combination, which uses no elements.
--
--   The above description, straight from the book, is the single most
--   unhelpful hint I've ever been given in my life. The way the words "slots"
--   and "result" are used is actively misleading and unhelpful.

function combinations(n,m,a)
  local copy = table.move(a, 1, #a, 1, {})

  if n < m then return {} end
  if m == 0 then return {{}} end

  local results = {}
  local first = table.remove(copy, 1)

  for _, combo in ipairs(combinations(n-1,m-1,copy)) do
    table.insert(combo, 1, first)
    table.insert(results, combo)
  end
  for _, combo in ipairs(combinations(n-1,m,copy)) do table.insert(results, combo) end
  return results
end

combos = combinations(3,2,{0,1,2,3,4})
for _, v in ipairs(combos) do print(table.unpack(v)) end

--[[
The algorithm doesn't click. I understand it on a very high level and I can
implement it but I don't understand the concept at a level where I could
explain exactly why du n-1,m-1 in one case but n-1,m in the other.
                                                                     3,2,{0,1,2,3,4}
                          +------------------------------------------------+------------------------------------------------+
                          | {{0,1}, {0,2}, {1,2}}
              +-----------+----------------------------+
              |                                        |
        2,1,{1,2,3,4}                            2,2,{1,2,3,4}
              |{{1}},{2}}                              |  {{1,2}}
       +------+-------+                          +-----+----------------+
       |              |                          |                      |
   1,0,{2,3,4}     1,1,{2,3,4}                1,1,{2,3,4}           1,2,{2,3,4}
      {{}}            | {{2}}                    | {{2}}                 |  {{}}
                +-----+------+             +-----+------+          +-----+------+
                |            |             |            |          |            |
             0,0,{3,4}     0,1,{3,4}    0,0,{3,4}    0,1,{3,4}   0,1,{3,4}     1,1,{3,4} 
               {{}}          {}            {{}}         {}         {}              | {{}}
                                                                              +----+-----+
                                                                              |          |
                                                                           0,0,{4}     0,1,{4}
                                                                            {{}}         {}
--]]
