-- 13.6 Implement a bit array that has newBitArray, setBit, and testBit
-- https://stackoverflow.com/questions/47981/how-do-you-set-clear-and-toggle-a-single-bit
function newBitArray(n)
  local arr, len = {}, math.ceil(n / 8)
  for i = 1, len do table.insert(arr, 0) end
  return arr
end

function setBit(a,n,v)
  if v == 1 then
    a[n // 8] = a[n // 8] | (v << n)
  else
    a[n // 8] = a[n // 8] & ~(v << n)
  end
end


function hasBit(a,n)
  return a[n // 8] >> n & 1
end

local arr = newBitArray(10)
setBit(arr, 9, 1)
print(hasBit(arr, 9))
print(hasBit(arr, 8))
setBit(arr, 8, 1)
print(hasBit(arr, 8))
