-- 23.1 Write an experiment to determine if ephemeron tables really work
local cache = setmetatable({}, {__mode = "k"})
local function foo(o)
  cache[o] = function () return o end
  return cache[o]
end
foo({})
-- foo("doesn't work because strings aren't weak, ever")
collectgarbage()
for k,v in pairs(cache) do print(k,v) end
