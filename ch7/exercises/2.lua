-- 7.1 Write a program that reads and sorts a file. No arguments, read and write stdin/stdout. One file name read from that, two file names read and write to those
-- 7.2 Change previous program so it asks for confirmation if output file exists

input = io.input()
if arg[1] then
  input = io.open(arg[1])
end

output = io.output()
if arg[2] then
  local f = io.open(arg[2])
  -- This won't work for permission denied. I think this will be extremely hard
  -- to do cross platform. I could check the error code but that will only work
  -- on Unix.
  if f then
    f:close()
    io.write("file exists, proceed?")
    local yn = io.stdin:read(1)
    if yn == "n" then
      os.exit(0)
    end
  end
  output = io.open(arg[2], "w")
end

lines = {}
for line in input:lines() do
  table.insert(lines, line)
end

table.sort(lines)

for _, line in ipairs(lines) do
  output:write(line, "\n")
end

input:close()
output:close()
