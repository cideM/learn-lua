local q, data = require"1"
print(data)

local list = q.new()
q.pushFirst(list, 5)
print(q.popFirst(list))
