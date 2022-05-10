-- 21.3 Reimplement Stack using a dual representation

local stacks = {}

local Stack = {}

function Stack:new()
	local o = {}
  stacks[o] = {}
	self.__index = self
	setmetatable(o, self)
	return o
end

function Stack:push(x)
  table.insert(stacks[self], x)
end

function Stack:top()
  local len = #stacks[self]
  return stacks[self][len]
end

local stack1 = Stack:new()
local stack2 = Stack:new()
stack1:push(1)
stack2:push(2)
print(stack1:top(), stack2:top())

