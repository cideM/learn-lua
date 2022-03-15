-- 17.1 Rewrite 14.2 double ended queues as a proper module

local M = {}

M.new = function ()
  return {first = 0, last = -1}
end

M.pushFirst = function (list, value)
  local first = list.first - 1
  list.first = first
  list[first] = value
end

M.pushLast = function (list, value)
  local last = list.last + 1
  list.last = last
  list[last] = value
end

M.popFirst = function (list)
  local first = list.first
  if first > list.last then error("list is empty") end
  local value = list[first]
  list[first] = nil -- for GC
  list.first = first + 1
  return value
end

return M
