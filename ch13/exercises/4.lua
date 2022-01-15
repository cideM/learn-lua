-- 13.4 Write a function to compute the hamming weight
-- https://en.wikipedia.org/wiki/Hamming_weight#Efficient_implementation

--[[
The presented Hamming Weight algorithm counts groups of bits and stores the
number of set bits in the bits of that group. It reuses the bit set for
counting.

The basic idea can be understood with a simple example. The first row in the
algorithm below counts pairs of 2 bits. So let's take 11 (= 3).
3 - ((3 >> 1) & 0x5555555555555555)
0x5555555555555555 is just 01 repeated so...
b11 - (b01 & b01)
b11 - b01
3 - 1 = 2 or b10

You can see that you started with b11 and you ended up with b10. Still 2 bits,
now they store the count, instead of the number.
--]]
function hamming(n)
  n = n - ((n >> 1) & 0x5555555555555555)
  n = (n & 0x3333333333333333) + ((n >> 2) & 0x3333333333333333)
  n = (n + (n >> 4)) & 0x0f0f0f0f0f0f0f0f
  n = n + (n >> 8)
  n = n + (n >> 16)
  n = n + (n >> 32)
  return n & 0x7f
end

print(hamming(27834))
