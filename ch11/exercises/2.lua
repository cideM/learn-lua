-- 11.2 Ignore words from ignore list
local ignored = {}

io.input(arg[1])
for line in io.input():lines() do
  ignored[line] = true
end
io.input():close()

local counter = {}

io.input(io.stdin)

for line in io.lines() do
  for word in string.gmatch(line, "%w+") do
    if not ignored[word] then
      counter[word] = (counter[word] or 0) + 1
    end
  end
end

local words = {}

for w in pairs(counter) do
  words[#words + 1] = w
end

table.sort(words, function (w1, w2)
  return counter[w1] > counter[w2] or
         counter[w1] == counter[w2] and w1 < w2
end)

local n = math.min(tonumber(arg[1]) or math.huge, #words)

for i = 1, n do
  io.write(words[i], "\t", counter[words[i]], "\n")
end

