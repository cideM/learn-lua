-- 7.3 Compare the performance of Lua copying stdin to stdout
-- byte
-- line <-- here
-- 8 kb
-- whole file

local b = io.read("L")
while b do
  io.write(b)
  b = io.read("L")
end
