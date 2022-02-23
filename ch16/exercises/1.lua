-- 16.1 Write a function loadwithprefix that works like load but adds a prefix.
--    Should accept both strings and reader functions. In the case of a string
--    it should not directly concatenate the prefix but rather call load with a
--    reader function.

-- I'm specifically asked to implement this with a reader function and load
function loadwithprefix(prefix, chunk)
  local args = {prefix, chunk}
  local reader = function()
    local current = table.remove(args, 1)
    local t = type(current)
    if t == "string" then
      return current
    elseif t == "function" then
      return current()
    else
      return nil
    end
  end
  return load(reader)
end

f = loadwithprefix("x = 10;", "x = x + 1")
f()
print(x)

f = loadwithprefix("x = 10;", io.lines("ch16/exercises/1_input.lua", "L"))
f()
print(x)
