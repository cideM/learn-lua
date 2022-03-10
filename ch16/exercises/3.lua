-- 16.3 Write stringrep for a fixed n which builds a Lua chunk and uses "load"
--    to produce the actual function.

local function stringrep_n (n)
  local args = {"function stringrep_" .. tostring(n) .. " (s)", "local buf = {s}"}
  for _ = 1, n - 1 do
    table.insert(args, "table.insert(buf, s)")
  end
  table.insert(args, "print(table.concat(buf))")
  table.insert(args, "return table.concat(buf)")
  table.insert(args, "end")

  local chunk = table.concat(args, "\n")
  print(chunk)
  return assert(load(chunk))()
end

stringrep_n(5)
print(stringrep_5("hi"))
