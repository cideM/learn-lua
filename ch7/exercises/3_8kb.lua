-- 7.3 Compare the performance of Lua copying stdin to stdout
-- byte
-- line
-- 8 kb <-- here
-- whole file

local b = io.read(8)
while b do
  io.write(b)
  b = io.read(8)
end
