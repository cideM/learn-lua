local function dofile(filename)
  local f = assert(loadfile(filename))
  return f()
end

-- Let's see assert in action
-- dofile("foo")

local f = load("function test() print('hmmm') end")
f()
-- This actually works and calls the newly added test function
test()

-- Every chunk is turned into an anonymous variadic function, that's important.
-- So we can use the vararg expression of whatever the ... is called to use
-- arguments passed in when we later call our function
local f2 = assert(load("print(...)"))
f2(5)
