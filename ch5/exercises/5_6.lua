-- Write a function to test whether a given table is a valid sequence
function issequence(t)
  local last = nil
  for k,v in pairs(t) do
    if type(k) ~= "number" then return false end
    if not last then
      if k ~= 1 then return false end
      last = k
    else
      if k - 1 ~= last then return false end
    end
  end
  return true
end

assert(issequence({}))
assert(issequence({1}))
assert(issequence({"a", "b"}))
assert(not issequence({ [1] = 2, [3] = 4 }))
assert(not issequence({ ["1"] = 2 }))
