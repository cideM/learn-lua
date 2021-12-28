-- 7.4 Read the last n lines without reading entire file

f = assert(io.open(arg[1], "r"))

size = f:seek("end")
f:seek("cur", -2)

num_lines = tonumber(arg[2])
c, offset, num_lines_found = f:read(1), size - 2, 0

while offset > 0 and num_lines_found < num_lines do
  f:seek("cur", -2)
  c = f:read(1)
  if c == "\n" then num_lines_found = num_lines_found + 1 end
  offset = offset - 1
end

for line in f:lines() do
  io.write(line,"\n")
end

f:close()


