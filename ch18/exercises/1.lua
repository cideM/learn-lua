-- 18.1 Write an iterator fromto such that the next loop becomes equivalent to a
-- numeric for:
-- for i in fromto(n, m) do <body> end
-- Can you implement it as a stateless iterator?

local function fromto(n, m)
  local iter = function (state, control)
    -- Trick so that we don't skip the first value, here n
    if not control then return n end
    if control == m then return nil end
    -- first return value is the new control variable, everything else is
    -- discarded
    return control + 1
  end

  local state, control = nil, nil
  return iter, state, control
end

for i in fromto(1,5) do
  print(i)
end

for i = 1, 5 do
  print(i)
end
