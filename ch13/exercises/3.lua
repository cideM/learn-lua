-- 13.3 Test whether a given integer is a power of two
function ispow2(n)
  if n <= 1 then return false end
  local r = math.log(n, 2)
  return math.floor(r) == r
end

print(ispow2(0))
print(ispow2(1))
print(ispow2(2))
print(ispow2(6))
print(ispow2(3))
print(ispow2(256))

local function bits(num)
  if num == 0 then return {0} end
  local bits, n = {}, num
  while n > 0 do
    table.insert(bits, 1, (n & 1) == 1 and "1" or "0")
    n = n >> 1
  end
  return bits
end

-- Check if only one bit is set.
function ispow2_2(num)
  if num <= 1 then return false end
  local bits_num, sum = bits(num), 0
  for _, n in ipairs(bits_num) do sum = sum + n end
  return sum == 1
end

print("ispow2_2")
print(ispow2_2(0))
print(ispow2_2(1))
print(ispow2_2(2))
print(ispow2_2(6))
print(ispow2_2(3))
print(ispow2_2(256))

