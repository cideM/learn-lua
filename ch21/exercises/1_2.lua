-- 21.1 Implement a class Stack with push, pop, top, and isempty
-- 21.2 Implement a subclass StackQueue that adds insertbottom

Stack = { values = {} }

function Stack:new()
  local o = { values = {} }
  self.__index = self
  setmetatable(o, self)
  return o
end

function Stack:push(x)
  table.insert(self.values, x)
end

function Stack:pop()
  return table.remove(self.values)
end

function Stack:top()
  return self.values[#self.values]
end

function Stack:isempty()
  return #self.values == 0
end

local stack = Stack:new()
local stack2 = Stack:new()
stack2:push(10)
stack:push(2)

-- This should print 10, not 2. If it prints 2 it means all stacks share the
-- same underlying table. Notice that the example from the book is, in my
-- opinion, quite misleading. In the book, the table you pass to Stack:new is
-- optional. But if you don't pass in a table, then self.values will always
-- refer to the original, single "values" field in the global "Stack" table.
-- After all that's how metatable lookups work. Realistically, you have to
-- provide a new table that has a "values" field for the stacks to have their
-- own individual state. I'm not sure why the book doesn't make this clear.
print("should print 10:", stack2:top())
print("should print 2:", stack:top())
stack:push(3)
print("stack", stack:top())
print("stack", stack:pop())
print("stack", stack:pop())
print("stack", stack:isempty())

local StackQueue = Stack:new()

function StackQueue:insertbottom(x)
  table.insert(self.values, 1, x)
end

local sq = StackQueue:new()
sq:push(1)
sq:insertbottom(4)
print(sq:pop())
print(sq:pop())
