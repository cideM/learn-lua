-- 25.1 Modify the getvarvalue function so it works on coroutines as well
b = 5
local c = 10

function foo()
	local a = 4
	-- without this, C doesn't show up as upvalues
	local d = c
	coroutine.yield(a)
end

function getvarvalue(name, level, isenv, thread)
	local value
	local found = false

	level = (level or 1) + 1

	-- try local variables
	for i = 1, math.huge do
		local n, v
		if thread then
			-- level out of range
			if not debug.getinfo(thread, level - 1) then
				break
			end
			n, v = debug.getlocal(thread, level - 1, i)
		else
			n, v = debug.getlocal(level, i)
		end
		if not n then
			break
		end
		if n == name then
			value = v
			found = true
		end
	end
	if found then
		return "local", value
	end

	-- try non-local variables
	local func
	if thread and debug.getinfo(thread, level - 1) then
		func = debug.getinfo(thread, level - 1, "f").func
	else
		func = debug.getinfo(level, "f").func
	end
	if func then
		for i = 1, math.huge do
			local n, v = debug.getupvalue(func, i)
			if not n then
				break
			end
			if n == name then
				return "upvalue", v
			end
		end
	end

	if isenv then
		return "noenv"
	end -- avoid loop

	-- not found; get value from the environment
	local _, env = getvarvalue("_ENV", level, true, thread)
	if env then
		return "global", env[name]
	else
		return "noenv"
	end
end

local co = coroutine.create(foo)
coroutine.resume(co)
-- print(getvarvalue("a", 1, false, co))
print(getvarvalue("b", 1, false, co))
-- print(getvarvalue("c", 1, false, co))
return {
	getvarvalue = getvarvalue,
}
