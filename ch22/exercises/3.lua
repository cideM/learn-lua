-- 22.3 Explain in detail
local print = print
function foo (_ENV, a)
  print(a + b)
end

foo({b = 14}, 12)
foo({b = 10}, 1)

-- Uuuhhmm okay are assigning to _ENV through the function parameter name?
-- That's so weird.
