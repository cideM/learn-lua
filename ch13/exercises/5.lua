-- 13.5 Write a function to check whether a binary representation of a number is a palindrome
local function bits(num)
  if num == 0 then return {0} end
  local bits, n = {}, num
  while n > 0 do
    table.insert(bits, 1, (n & 1) == 1 and "1" or "0")
    n = n >> 1
  end
  return bits
end

function palindrome(num)
  local reverse, n = 0, num
  -- Look at one bit of "num" at a time. If it's 1, we add it to reverse by
  -- XOR. It's a fancy and very fast way of popping the last element of num and
  -- appending it to the end of reverse.
  while n > 0 do
    reverse = reverse << 1
    if n & 1 == 1 then reverse = reverse ~ 1 end
    n = n >> 1
  end
  return reverse == num
end

print(palindrome(5))
print(palindrome(1))
print(palindrome(2))
