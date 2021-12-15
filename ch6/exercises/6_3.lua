-- Write a function that takes an arbitrary number of values and returns all of
-- them, except the last one.
function head(...)
  -- Not ideal that we're allocating a new table plus the select call but I
  -- can't see a way around creating a table. Select doesn't let you set an
  -- upper bound.
  return table.unpack(table.pack(...), 1, select("#", ...) - 1)
end

print(head(1,2,3))
