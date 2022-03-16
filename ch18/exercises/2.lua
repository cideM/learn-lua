-- 18.2 Add a step parameter to 18.1, can it remain stateless?

local function fromto(n, m, step)
  local iter = function (state, control)
    if not control then return n end
    if control >= m then return nil end
    -- first return value is the new control variable, everything else is
    -- discarded
    return control + step
  end

  local state, control = nil, nil
  return iter, state, control
end

for i in fromto(1,5,2) do
  print(i)
end

for i = 1, 5, 2 do
  print(i)
end

