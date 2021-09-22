print(type(nil))
print(type(true))
print(type(1))
print(type(""))
print(type(type))
print(type(io.stdin))

print(uninitialized)
print(type(uninitialized))

empty_string = ""
if empty_string then
  print("this is not javascript")
end

zero = 0
if zero then
  print("this really is not javascript")
end

-- This is useful, remember it well!
foo = foo or "default"
print(foo)

-- This is a Lua ternary, like false ? 0 : 1
print(false and 0 or 1) -- should print 1
print("hi" and 0 or 1) -- should print 0
