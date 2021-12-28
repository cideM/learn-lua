-- io.read returns nil if the current byte is not a number
-- lua ch7/io.lua < ch7/num_test.txt doesn't work
-- io.write(io.read("n"))

-- Can be handy for fixed input because you can skip tonumber()
_, a, _, b, _, c = io.read(4, "n", 1, "n", 5, "n")
print(a,b,c)
print(type(a))

io.stdout:write("Hello!")

f = assert(io.open("ch7/test.txt", "r"))
io.stdout:write(f:read("a"))

-- interestingly this doesn't error
f:write("foo")

-- so far there doesn't appear to be r/w; I checked online and there is! w+ and
-- r+
f = assert(io.open("ch7/test.txt", "w+"))
f:write("foo")
io.stdout:write(f:read("a"))
f:close()
