-- 14.2 Modify the queue implementation so that both indices return to zero when the queue is empty.

function listNew()
  return { first = 0, last = -1 }
end

function pushFirst(list, value)
  local first = list.first - 1
  list.first = first
  list[first] = value
end

function popFirst(list)
  local first = list.first
  if first > list.last then error("list is empty") end
  local value = list[first]
  list[first] = nil
  list.first = first + 1
  return value
end

function popLast(list)
  local last = list.last
  if list.first > last then error("list is empty") end
  local value = list[last]
  list[last] = nil
  list.last = last - 1
  return value
end

local l = listNew()
pushFirst(l, 4)
pushFirst(l, 5)
print(popFirst(l))
print(popLast(l))
-- queue is empty but indeces are -1 and -2
print(l.first, l.last)

--[[
This question is surprisingly tricky. If we call pushFirst three times and then
popLast three times we'll end up with -3 -3. I could solve it by always
creating a new queue. Then we could make popLast check if last is 0 and in that
case modify first AND shift the entire queue. But that's quite heavy. The
quickfix would be to just track the queue length and then hardcode a condition
that either pop* function returns the zero list if the length is 0.

In the end, I didn't add a length but still went for the unelegant solution
with a special check in the pop* functions.
--]]
function listNew2()
  return { first = 0, last = 0 }
end

function pushFirst2(list, value)
  local first = list.first - 1
  local last = (list.first == 0 and list.last == 0) and first or list.last
  list.first = first
  list.last = last
  list[first] = value
end

function popFirst2(list)
  local first = list.first
  if first == 0 and last == 0 then error("list is empty") end
  local value = list[first]
  list[first] = nil
  list.first = first + 1
  if list.first > list.last then
    list.first = 0
    list.last = 0
  end
  return value
end

function popLast2(list)
  local last = list.last
  if first == 0 and last == 0 then error("list is empty") end
  local value = list[last]
  list[last] = nil
  list.last = last - 1
  if list.last < list.first then
    list.first = 0
    list.last = 0
  end
  return value
end

local l = listNew2()
pushFirst2(l, 4)
pushFirst2(l, 5)
print(popFirst2(l))
print(popLast2(l))
print(l.first, l.last)
