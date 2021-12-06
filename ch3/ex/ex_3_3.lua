for i = -10, 10 do
  print(i, i % 3)
end

-- Haha good one. You really need to look at how % is defined:
-- a % b == a - ((a // b) * b)
-- because for negative numbers this doesn't give you the results you might
-- expect.
