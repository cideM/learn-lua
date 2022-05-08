-- 21.1 Implement a class Stack with push, pop, top, and isempty

Stack = { values = {} }

-- I found this self.__index = self confusing initially.
-- But think about what really happens: you have    

function Stack:new(o)
  o = o or {}
  self.__index = self
  setmetatable(o, self)
  return o
end
