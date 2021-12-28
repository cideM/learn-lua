-- 7.3 Compare the performance of Lua copying stdin to stdout
-- byte
-- line
-- 8 kb
-- whole file <-- here
io.write(io.read("a"))
