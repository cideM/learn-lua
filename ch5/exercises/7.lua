-- Write a function that inserts all elements of a given list into a given
-- position of another list
function insert(t, target, pos)
  local original_len = #target
  -- Grow the target
  for i = 1, #t do table.insert(target, "") end

  for i = pos, pos + #t - 1 do
    -- Shift the original values until we've run past the end of the original
    -- list
    if i >= pos and i <= original_len then target[i + #t] = target[i] end

    -- Insert new value
    target[i] = t[i - pos + 1]
  end
end

function insertcheap(t, target, pos)
  for i, v in ipairs(t) do
    table.insert(target, pos + i - 1, v)
  end
end

t = {"A","B","C"}
insertcheap({1,2,3}, t, 2)
print(table.concat(t, ","))

t = {"A","B","C"}
insert({1,2,3}, t, 2)
print(table.concat(t, ","))

t = {}
insert({1,2,3}, t, 1)
print(table.concat(t, ","))
