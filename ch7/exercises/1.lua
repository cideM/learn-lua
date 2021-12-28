-- 7.1 Write a program that reads and sorts a file. No arguments, read and write stdin/stdout. One file name read from that, two file names read and write to those

io.input(arg[1])
io.output(arg[2])

lines = {}
for line in io.input():lines() do table.insert(lines, line) end

table.sort(lines)

for _, line in ipairs(lines) do io.output():write(line, "\n") end

io.input():close()
io.output():close()
