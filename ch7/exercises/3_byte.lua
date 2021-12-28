-- 7.3 Compare the performance of Lua copying stdin to stdout
-- byte <-- here
-- line
-- 8 kb
-- whole file

local b = io.read(1)
while b do
  io.write(b)
  b = io.read(1)
end
