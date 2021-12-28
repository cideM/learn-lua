-- 7.4 Read the last line without reading the entire file

f = assert(io.open(arg[1], "r"))

size = f:seek("end")
f:seek("cur", -2)
c, offset = f:read(1), size - 2

while c ~= "\n" and offset > 0 do
  f:seek("cur", -2)
  c = f:read(1)
  offset = offset - 1
end

io.write(f:read("l"))

f:close()

