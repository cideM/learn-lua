-- 18.4 Write an iterator that returns all non-empty substrings of a given
--    string

local function substrings(s)
  local low = 1
  local high = 1

  local iter = function ()
    local out = string.sub(s, low, high)
    if low > #s then return nil end
    if high >= #s then
      low = low + 1
      high = low
    else
      high = high + 1
    end
    return out
  end

  return iter
end

for s in substrings("abcd") do
  print(s)
end
