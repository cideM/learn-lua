-- 18.3 Write an iterator uniquewords that operates on a file

local function allwords(f)
  local line = f:read()
  local pos = 1
  local seen = {}
  return function ()
    while line do
      local word, new_pos = string.match(line, "(%w+)()", pos)
      if word then
        pos = new_pos
        if not seen[word] then
          seen[word] = true
          return word
        end
      else
        line = f:read()
        pos = 1
      end
    end
    return nil
  end
end

local f = io.open("ch18/exercises/words.txt")
for w in allwords(f) do
  print(w)
end
f:close()
