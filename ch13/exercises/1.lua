-- 13.1 Write a function to compute the modulo operation for unsigned integers
-- The example from the book only works up until Lua 5.3.4 it seems, see:
-- http://lua-users.org/lists/lua-l/2018-12/msg00061.html
-- The solution is to write the number as hex when storing as a variable or 3
-- << 62

uint = 3 << 62
print(uint)
print(string.format("%u", uint))
print(string.format("subtraction: %u", uint - uint))

function udiv(n, d)
  -- We can't just do normal division because Lua will interpret every number
  -- as signed, meaning the highest bit will be interpreted as 1 (minus) or 0
  -- (plus), rather than part of the number.

  -- We're not actually checking if d is lower than 0! Remember, unsigned
  -- division! If d < 0 then the highest bit has to be 1, meaning the number
  -- has to be larger than 2^63. Since there's an upper bound on what number we
  -- can handle (unless we specifically work with some BigInt representation),
  -- the quotient can then only be 1 or 0. More specifically, it would be 1.x
  -- or 0.x but I guess this function doesn't return a flot.
  if d < 0 then
    -- ult = unsigned larger than
    if math.ult(n, d) then return 0 else return 1 end
  end

  -- Wow, so this is actually super simple and kind of cool.
  -- 5 // 4 = 1
  -- This part of the algorithm effectively does:
  -- 5 // 2 = 2
  -- 2 // 4 = 0
  -- 0 * 2 = 0
  -- Then the next part, with math.ult again, would correct this:
  -- 0 + 1 = 1
  -- ... which is the correct result! Let's try another.
  -- 10 // 4 = 2
  -- 5 // 4 = 1
  -- 1 * 2 = 2
  -- Done!
  -- The idea here is that we divide by two first, so we get below 2^63 and can
  -- use normal floor division.
  local halfed = n >> 1
  local floored = halfed // d
  local doubled = floored << 1
  local r = n - doubled * d

  if not math.ult(r, d) then doubled = doubled + 1 end

  return doubled
end

function modulo(n, d)
  local div = udiv(n, d)
  return div, n - d * div
end

-- This gives the expected result, which is 1 (result of division) and 0, the
-- remainder.
print(string.format("modulo: %u", modulo(uint, uint)))

print(string.format("modulo: %u", modulo(uint, 1)))
