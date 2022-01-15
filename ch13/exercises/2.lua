-- 13.2 Implement different ways to compute the number of bits in the
--    representation of a Lua integer.

-- I didn't think of this myself, got it from:
-- https://stackoverflow.com/questions/9079853/lua-print-integer-as-a-binary
-- It's quite clever since it essentially just checks if the least significant
-- bit it 1 or 0 and then it right shifts the number. Rinse and repeat until 0.
-- For 11:
-- 1011 -> 1
--  101 -> 1
--   10 -> 0
--    1 -> 1
-- -> 1011
-- In a way this feels like a hack because bitwise operators operate on, and
-- return, integers, while converting them to their bit representation under
-- the hood. So in a sense the bitwise operator does exactly what my function
-- does.
local function bits(num)
  if num == 0 then return {0} end
  local bits, n = {}, num
  while n > 0 do
    table.insert(bits, 1, (n & 1) == 1 and "1" or "0")
    n = n >> 1
  end
  return bits
end
 
print(table.concat(bits(11)))
print(#bits(11))
print(#bits(1))
print(#bits(0))

-- Another really interesting approach if you're only interested in the number
-- of bits is using a logarithm. Since it's binary, we use base 2. Then we just
-- need to know how many times we need to raise 2 to get to the provided
-- number.
local function bits2(n)
  if n == 0 then return 1 end
  return math.floor(math.log(n,2) + 1)
end

print(bits2(11))
print(bits2(1))
print(bits2(0))
