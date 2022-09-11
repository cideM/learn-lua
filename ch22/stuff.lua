print(debug.getinfo(2, "S").what) -- C

local function foo()
  print(debug.getinfo(2, "S").what) -- main
end

foo()
