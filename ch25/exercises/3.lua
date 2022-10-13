-- 25.3 Write a version of getvarvalue that returns a table with all variables
--    that are visible at the calling function. (The returned table should not
--    include environment variables; instead, it should inherit them from the
--    original environment.)

-- no need to pass in a level, since we explictly want this to work for the
-- calling function, which is stack level 1. But calling function here means
-- function that calls getinfo, so we need to increase the level by 1 for the
-- caller for getvarvalues
local function getvarvalues(level)
  local level = level or 2
	local values = {}

	for i = 1, math.huge do
		local k, v = debug.getlocal(level, i)
		if not k then
			break
		end
		values[k] = v
	end

	local func = debug.getinfo(level, "f").func
	local env
	for i = 1, math.huge do
		local k, v = debug.getupvalue(func, i)
		if not k then
			break
		end
		if k == "_ENV" then
			env = v
		else
			values[k] = v
		end
	end

	if env then
		setmetatable(values, { __index = env })
	end

	return values
end

b = 5
local c = 10

do
	local f = 12
	function foo()
		local a = 4
		local b = f
		local d = c
		local e = b
		local vars = getvarvalues()
		for k, v in pairs(vars) do
			print(k, v)
		end
		coroutine.yield()
	end
end

local co = coroutine.create(foo)
coroutine.resume(co)

return {
	getvarvalues = getvarvalues,
}
