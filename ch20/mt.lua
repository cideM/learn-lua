-- Let's define a __pairs metamethod that does something weird

local mt = {}

local function new(t)
  local out = {}
  for _, v in ipairs(t) do
    table.insert(out, v)
  end
  setmetatable(out, mt)
  return out
end

local function __pairs(t)
  local runs = 1
  local iter = function (_, _)
    if runs > #t then return nil end
    runs = runs + 1
    local r = math.random(#t)
    return r, t[r]
  end

  return iter
end

mt.__pairs = __pairs

local foo = new{"a", "b", "c"}
for k, v in pairs(foo) do print(k, v) end
