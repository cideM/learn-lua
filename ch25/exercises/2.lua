-- 25.2 Like getvarvalue create setvarvalue

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

b = 5
local c = 10

do
	local f = 12
	function foo()
		local a = 4
		print("before", a, b, c, f)
		coroutine.yield()
		print("after", a, b, c, f)
	end
end

function setvarvalue(name, level, value, thread)
	level = (level or 1) + 1

	if thread and not debug.getinfo(thread, level - 1) then
		return "notfound"
	end

	-- try local variables
	for i = 1, math.huge do
		local n
		if thread then
			n = debug.getlocal(thread, level - 1, i)
		else
			n = debug.getlocal(level, i)
		end
		if not n then
			break
		end
		if n == name then
			if thread then
				debug.setlocal(thread, level - 1, i, value)
			else
				debug.setlocal(level, i, value)
			end
			return "local", n, value
		end
	end

	-- try non-local variables
	local func
	if thread then
		func = debug.getinfo(thread, level - 1, "f").func
	else
		func = debug.getinfo(level, "f").func
	end
	if func then
		for i = 1, math.huge do
			local n = debug.getupvalue(func, i)
			if not n then
				break
			end
			if n == name then
				debug.setupvalue(func, i, value)
				return "upvalue", n, value
			end
		end
	end

	local _, env = getvarvalue("_ENV", level, true, thread)
	if env then
		env[name] = value
		return "global", env[name], value
	else
		return "noenv"
	end
end

local co = coroutine.create(foo)
coroutine.resume(co)
print(setvarvalue("a", 1, 100, co))
print(setvarvalue("b", 1, 500, co))
print(setvarvalue("c", 1, 1000, co))
print(setvarvalue("f", 1, 22, co))
coroutine.resume(co)

return {
	getvarvalue = getvarvalue,
	setvarvalue = setvarvalue,
}
