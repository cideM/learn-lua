-- 13.7 Write a program to read a binary file and sum the value fields
--[[
struct Record {
  int x;
  char [3] code;
  float value;
}
--]]

function generateFile(filename)
  local s = string.pack("i c3 n", 213, "abc", 2.5)
  local f = io.open(filename, "wb")
  f:write(s)
  f:write(s)
  f:close()
end

function parse(filename)
  local f = io.open(filename, "rb")
  local s = f:read("a")
  f:close()

  local sum, i = 0, 1
  while i < #s do
    local x, code, value, j = string.unpack("i c3 n", s, i)
    i = j
    sum = sum + value
  end

  return sum
end

generateFile(arg[1])
print(parse(arg[1]))
