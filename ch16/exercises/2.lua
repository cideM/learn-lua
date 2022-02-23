-- 16.2 Write a function multiload that generalizes loadwithprefix from 16.1

function multiload(...)
  local chunks = {...}
  local position = 1

  local reader
  reader = function()
    if position > #chunks then return nil end
    local current = chunks[position]
    local t = type(current)

    -- drain the current reader first
    if t == "function" then
      local ret = current()
      -- reader still has values
      if ret then return ret end
      position = position + 1
      return reader()
    end

    -- must be string
    position = position + 1
    return current
  end

  return assert(load(reader))
end

f = multiload("x = 10;", io.lines("ch16/exercises/1_input.lua", "L"), io.lines("ch16/exercises/2_input.lua", "L"))
f()
print(x)
