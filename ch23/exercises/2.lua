-- 23.2 In the below example, what happens if the program doesn't run a GC
--    cycle, ends with an error or calls os.exit()

-- I'd assume it will always run the finalizers when the Lua state ends. I'm not
-- sure about "doesn't run a GC cycle". I can try turning GC off, but I think
-- the finalizers still run?

-- still prints
-- collectgarbage("stop")
o = { x = "hi" }
setmetatable(o, {
	__gc = function(o)
		print(o.x)
	end,
})
o = nil
-- prints
-- _ = io.open("doesn't exist")
-- prints
-- os.exit(0)



