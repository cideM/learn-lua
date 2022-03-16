-- 18.5 Write a *true* iterator that traverses all subsets of a given set

local function bits(num)
  if num == 0 then return {0} end
  local bits, n = {}, num
  while n > 0 do
    table.insert(bits, 1, (n & 1) == 1 and "1" or "0")
    n = n >> 1
  end
  return bits
end

local function subsets(set, f)
  local cache = {}
  for i = 1, 1 << #set do
    local index, inserted = i, 0
    for j = #set, 1, -1 do
      if index & 1 == 1 then
        table.insert(cache, 1, set[j])
        inserted = inserted + 1
      end
      index = index >> 1
    end
    if inserted > 0 then
      f(table.unpack(cache, 1, inserted))
    end
  end
end

-- Not sure if this is cheating, since we're still generating a table per subset
-- but not in the geneartor
subsets({"a", "b", "c"}, function (...) print(table.concat({...})) end)
