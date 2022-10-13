lib = require("2")

function debug1()
	local env = {
		print = print,
	}
	setmetatable(env, {
		__newindex = function(_, k, v)
			lib.setvarvalue(k, 4, v)
		end,
		__index = function(_, k)
			local _, v = lib.getvarvalue(k, 4)
			return v
		end,
	})

	while true do
		io.write("debug> ")
		local line = io.read()
		if line == "cont" then
			break
		end
		assert(load(line, "debug", "t", env))()
	end
end

function foo()
	local a = 5
	debug1()
end

foo()
