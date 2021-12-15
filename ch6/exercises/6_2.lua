-- Write a function that takes an arbitrary number of values and returns all of them, except the first one

function tail(_, ...)
  return table.unpack({...})
end

print(tail(1,2,3))
