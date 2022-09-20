local co = coroutine.create(function()
	print("hi")
  return 4
end)
print(coroutine.status(co))
print(coroutine.resume(co))
print(coroutine.status(co))
print("------------")

local co2 = coroutine.create(function()
  for i=0, 10 do
    local v = coroutine.yield(i)
    print(string.format("i: %-10d v: %q", i, v))
  end
  return "done"
end)
for i=0, 11 do
  print(coroutine.resume(co2, i*2))
end
print(coroutine.status(co2))
print("------------")

-- Let's write an iterator
local iter = coroutine.wrap(function()
  for i=0,10 do
    coroutine.yield(i)
  end
end)

for i in iter do
  print("iter: ", i)
end
