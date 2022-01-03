-- 10.1 Write a split function. Pay special attention to how you handle empty strings.

function split(s, delim)
  local parts, offset = {}, 1
  for s in string.gmatch(s, "(.-)"..delim) do
    offset = offset + #s + 1
    table.insert(parts, s)
  end
  table.insert(parts, s:sub(offset))
  return parts
end

print("1")
local result = split("a whole new world", " ")
for _, s in ipairs(result) do print(s) end

print("2")
local result = split("", " ")
for _, s in ipairs(result) do print(s) end

print("3")
local result = split("a:b:i:p:u:random:garbage", ":")
for _, s in ipairs(result) do print(s) end
