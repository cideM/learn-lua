-- 14.1 Write a function to add two sparse matrices
local test = { 1, nil, 2 }
for k,v in pairs(test) do
  -- This indeed skips the nil entry but still gives you the correct index
  -- since the table indeces are the list positions.
  -- 1 1
  -- 3 2
  print(k,v)
end

function matrix_add(a,b)
  local m = {}
  for rowa = 1, #a do
    local row = {}
    for ia, va in pairs(a[rowa]) do
      row[ia] = (b[rowa][ia] or 0) + a[rowa][ia]
    end
    m[rowa] = row
  end
  return m
end

function printm(a)
  for k,v in pairs(a) do
    for kk, vv in pairs(v) do
      io.write(string.format("%4d", vv))
    end
    print("")
  end
end

local a = {
  { 3, 8 },
  { 4, 6 },
}
local b = {
  { 4, 0 },
  { 1, -9 },
}

local result = matrix_add(a, b)
printm(result)

local sparse = {
  { nil, nil },
  { 1, -9 }
}
local result = matrix_add(a, sparse)
printm(result)
