-- 23.5 Create a script that uses lots of memory and play with "pause" and
--    "stepmul". What happens if you set pause to zero? Pause 1000? Multiplier
--    zero, or 1,000,000? Stop GC and run it manually, can you make it faster?

cache = {}
setmetatable(cache, {__mode = "v"})
-- much slower
collectgarbage("setpause", 140)
collectgarbage("setstepmul", 150)
for i = 1, 1000000 do
  -- if i % 1000 == 0 then collectgarbage("step", 100) end
  table.insert(cache, { foo = "bar" })
end
-- Wow it's quite hard to make this faster than the defaults. I shaved off like
-- 1ms but with manual GC it just sucks. I also didn't experiment too much with
-- counting values and whatnot
